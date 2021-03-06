class EventsController < ApplicationController

    before_action :set_event, :only => [:show, :edit, :update, :destroy]

	def index
	  @events = Event.page(params[:page]).per(5)

	  respond_to do |format|
	    format.html # index.html.erb
	    format.xml { render :xml => @events.to_xml }
	    format.json { render :json => @events.to_json }
	    format.atom { @feed_title = "My event list" } # index.atom.builder
      end
	end

	def new
	  @event = Event.new
	end

	def create
	  @event = Event.new(event_params)
	  if @event.save
	  	flash[:notice] = "event was successsfully created"
        redirect_to events_path
      else
      	render :action => :new
      end
    end

    def show
      @event = Event.find(params[:id])
    end	

    def edit
    end

    def update
      if @event.update(event_params)
      	flash[:notice] = "event was successsfully updated"
        redirect_to event_path(@event)
      else
      	render :action => :edit
      end
    end

    def destroy
      @event.destroy
      flash[:alert] = "event was successsfully deleted"
      redirect_to events_path
    end

    private

    def event_params
      params.require(:event).permit(:name, :description, :category_id)
    end

    def set_event
      @event = Event.find(params[:id])
    end

end
