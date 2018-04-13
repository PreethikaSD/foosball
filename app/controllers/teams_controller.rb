class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :check_if_signed_in, only: [:create, :destroy, :new, :edit]
  before_action :calculate_winning_percentage, only: [:index]
  before_action :calculate_rank, only: [:index]

  # GET /teams
  # GET /teams.json
  def index
    yes = 1
    no = 0
    Team.all.each do |team|
      team.matches_won = 0
      team.matches_played = 0
      team.save
    end

    Match.all.each do |match|
      if match.winner != nil
        if match.team1 == match.winner
          winner_team = Team.find_by_id(match.team1)
          winner_team.matches_played += yes
          winner_team.matches_won += yes
          winner_team.save
          other_team = Team.find_by_id(match.team2)
          other_team.matches_played += yes
          other_team.matches_won += no
          other_team.save
        elsif match.team2 == match.winner
          winner_team = Team.find_by_id(match.team2)
          winner_team.matches_played += yes
          winner_team.matches_won += yes
          winner_team.save
          other_team = Team.find_by_id(match.team1)
          other_team.matches_played += yes
          other_team.matches_won +=no
          other_team.save
        else  
        end
      end
    end
    @teams = Team.all.order(:rank)
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)
    respond_to do |format|
      if @team.save
        format.html { redirect_to '/teams', notice: 'Team was successfully created.' }
        format.json { render :index, status: :created }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_team
    @team = Team.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def team_params
    params.require(:team).permit(:name, :matches_won, :matches_played)
  end

  def check_if_signed_in
    unless signed_in?
        redirect_back fallback_location: root_path, alert: "Please login to access this page"
    end
  end

  def calculate_winning_percentage
    Team.all.each do |team|
      if team.matches_played > 0 and team.matches_won > 0
        team.winning_percentage =  ((team.matches_won.to_f/team.matches_played.to_f)*100).round(2)
        team.save
      else
        team.winning_percentage = 0
        team.rank =  nil  
        team.save
      end
    end
  end

  def calculate_rank
    winning_percentage = Team.order(winning_percentage: :desc).pluck(:winning_percentage)
    rank = 1
    winning_percentage.each_with_index.map do |value,i|
      calculated_rank = winning_percentage[i-1] == value ? rank : rank = i+1
      t = Team.where(winning_percentage: value)
      t.each do |team|
        if team.winning_percentage == 0
          team.rank = nil 
        else  
          team.rank = calculated_rank
        end
        team.save
      end
    end  
  end
end
