class ProposalMailer < ApplicationMailer
  def proof_email(quest)
    @quest = quest
    mail( to: "moeandrew@hotmail.com", subject: 'Proof from Squire')
  end
  def proposal_email(quest)
    @quest = quest
    @duke = Duke.where(id: quest.duke_id).first
    mail( to: @duke.email, subject: 'Proposal from Squire')
  end
  def revised_proposal_email(quest)
    @quest = quest
    @squire = user.where(id: quest.squire_id).first
    mail( to: @squire.email, subject: 'Please Revise your proposal')
  end
  def warning_email(quest)
    @quest = quest
    @duke = Duke.where(id: quest.duke_id).first
    mail( to:@duke.email, subject: 'Your Quest has been flagged impossible by Squire')
  end
  def welcome_email(duke)
    @quest = quest
    @duke = duke
    mail( to: @duke.email, subject: "Welcome to Squire")
  end
  def message_email(quest)
    @quest = quest
    @duke = Duke.where(id: quest.duke_id).first
    mail( to: @duke.email, subject: "A message from your Squire")
  end
end
