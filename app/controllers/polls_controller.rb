class PollsController < ApplicationController
  before_filter :find_poll, :only => [:show, :show_options, :show_results, :vote]
  before_filter :require_participant, :only => [:show_options, :vote]

  def index
    @polls = Poll.all
  end
  
  def enter_code
    @target_url = poll_show_options_url params[:poll_id]
  end

  def show_options
  end
  
  def show_results
  end
  
  def vote
    @participant.votes_for = params[:poll][:participant][:votes_for].split ','
    @participant.votes_against = params[:poll][:participant][:votes_against].split ','
    @poll.save
    render :action => "show_options"
  end

  def new
    @poll = Poll.new
  end
  
  def show
  end

  # def edit
  # end

  def create
    @poll = Poll.new(params[:poll])
    if @poll.save
      flash[:notice] = 'Poll was successfully created.'
      redirect_to(@poll)
    else
      render :action => "new"
    end
  end

  def update
    if @poll.update_attributes(params[:poll])
      flash[:notice] = 'Poll was successfully updated.'
      redirect_to(@poll)
    else
      render :action => "edit"
    end
  end
  # 
  # def destroy
  #   @poll.destroy
  #   redirect_to(polls_url)
  # end

  private
    def find_poll
      @poll = Poll.find(params[:id] || params[:poll_id])
    end
    
    def require_participant
      @participant = @poll.get_participant(params[:code] || (params[:poll] && params[:poll][:participant] && params[:poll][:participant][:code]))
      Logger.new(STDOUT).info params[:code] || (params[:poll] && params[:poll][:participant] && params[:poll][:participant][:code])
      redirect_to :action => :enter_code, :poll_id => @poll._id unless @participant
    end

end
