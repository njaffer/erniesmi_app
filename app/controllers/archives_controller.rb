class ArchivesController < ApplicationController

	def new
		
	end	

	def save
		a = Archive.new
		a.title = params["title"]
		a.save
		
	end	
end
