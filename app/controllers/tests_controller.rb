# frozen_string_literal: true

class TestsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_test, only: %i[show start]
  before_action :set_user, only: %i[start]

  def index
    @tests = Test.all
  end

  def show
    @questions = @test.questions
  end

  def start
    @user.tests.push(@test)
    redirect_to @user.result(@test)
  end

  private

  def find_test
    @test = Test.find(params[:id])
  end

  def set_user
    @user = User.find(session[:user_id])
  end
end
