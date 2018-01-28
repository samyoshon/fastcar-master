class NewProposalNotifier < ActionMailer::Base
  default :from => 'any_from_address@example.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_new_proposal_notifier_email(user)
  	user.each do |u|
  		@user = u
	    mail( :to => u.email,
	    :subject => "My friend recommended you." )
	end
  end
end