class NoticeMailer < ApplicationMailer
    
    include Roadie::Rails::Automatic
    add_template_helper(ApplicationHelper)

    def confirm_mail()

    end
    def contact_mail(application)
        @application = JSON.parse(application)
        
        attachments.inline["logo.png"] = File.read("#{Rails.root.to_s}/app/assets/images/color_logo.png")
        subject = "#{@application['first_name']}様からのカーローン申し込み"
        mail(to: @application['email'], subject: subject)
    end
end
