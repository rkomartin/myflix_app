class UsersController < ApplicationController
  before_filter :require_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      @user.update_column(:token, SecureRandom.urlsafe_base64)
      @user.update_column(:admin, false)

      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
      Stripe::Charge.create(
        :amount => 999,
        :currency => "usd",
        :card => params[:stripeToken], # obtained with Stripe.js
        :description => "Sign up charge for #{@user.email}"
      )

      AppMailer.send_welcome_email(@user).deliver
      redirect_to sign_in_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new_with_invitation_token
    invitation = Invitation.where(token: params[:token]).first
    if invitation
      @user = User.new(email: invitation.recipient_email)
      render :new
    else
      redirect_to expired_token_path
    end
  end
end