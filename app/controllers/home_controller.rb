
class HomeController < ApplicationController
  protect_from_forgery :except => [:apply_mail]

  def index
  end

  def set_your_budget
  end

  def about_us
      render :layout => 'other_page'
  end

  def how_it_works
      render :layout => 'other_page'
  end
 
  def help_and_advice
      render :layout => 'other_page'
  end
  
  def apply
      render :layout => 'apply'
  end
  
  def apply2
      render :layout => 'apply2'
  end

  def business_apply
      render :layout => 'apply2'
  end


  def apply3
      render :layout => 'apply2'
  end
  
  def apply_mail
      @application = params.to_json
      NoticeMailer.contact_mail(@application).deliver

      personal = {'name' => 'Yamada'}
      render :json => personal
  end

  def upload_file
    uploaded_file = params[:file]
	output_path = Rails.root.join('public', uploaded_file.original_filename)
	
	File.open(output_path, 'w+b') do |fp|
	  fp.write  uploaded_file.read
	end

    vision = Google::Cloud::Vision.new(
        project: "46e9b8fc7d619db1971ff5d604b4858c5a95f33b",
        keyfile: Rails.root.to_s + "/lib/assets/spray-46e9b8fc7d61.json"
    )
    begin
        image = vision.image output_path
        annotation = vision.annotate image, document: true, text: true

        @visa_licence = visa_crop(annotation.text)        
        @driver_licence = driver_licence_crop(annotation.text)

        @word_data = Array.new
        prohabit_word_list = ["*", ".", "-", "NEW", "ZEALAND", "DRIVER", "LICENCE"]
        annotation.text.words.each do |word|
            if prohabit_word_list.include?(word.text) == false
                logger.debug word.text
                if word.text.to_i == 0
                    @word_data << word.text 
                end
            end
        end

        render :json => {"driver_licence" => @driver_licence.to_json, "words" => @word_data}
        #labels = annotation.labels.inject([]){|arr, label| arr << label.description}
    rescue Exception => e
        puts e.message
    end
  end


  def upload_file_visa
    uploaded_file = params[:file]
	output_path = Rails.root.join('public', uploaded_file.original_filename)
	
	File.open(output_path, 'w+b') do |fp|
	  fp.write  uploaded_file.read
	end

    vision = Google::Cloud::Vision.new(
        project: "46e9b8fc7d619db1971ff5d604b4858c5a95f33b",
        keyfile: Rails.root.to_s + "/lib/assets/spray-46e9b8fc7d61.json"
    )
    begin
        image = vision.image output_path
        annotation = vision.annotate image, document: true, text: true

        @visa_licence = visa_crop(annotation.text)        

        @word_data = Array.new
        prohabit_word_list = ["*", ".", "-", "NEW", "ZEALAND", "DRIVER", "LICENCE", "<"]
        annotation.text.words.each do |word|
            if prohabit_word_list.include?(word.text) == false
                logger.debug word.text
                if word.text.to_i == 0
                    @word_data << word.text 
                end
            end
        end

        render :json => {"words" => @word_data, "visa_licence" => @visa_licence.to_json}
        #labels = annotation.labels.inject([]){|arr, label| arr << label.description}
    rescue Exception => e
        puts e.message
    end
  end






  private 

  def visa_crop(text)
     visa_variable = {"Visa expiry: " => "expire_date", "Passport No: " => "passport_no", "Citizenship: " => "citizen_ship"}
     visa_type = ["Student Visa"]

     document = text.to_str
     visa_licence = Hash.new 
     document.each_line do |line|
        if visa_type.include?(line.chomp)
            visa_licence["visa_type"] = line.chomp
        end
        visa_variable.each do |licence_no, label|
            if line.include?(licence_no)
                data = line.split(licence_no)[1]
                licence_info = data.split(" ")[0]
                visa_licence[label] = licence_info
            end 
        end
     end
     return visa_licence
  end

  def driver_licence_crop(text)
     licence_variable = {"1. " => "last_name", "2. " => "first_name", "3. " => "birth_date", "4a. " => "issue_date", "4b. " => "expire_date", "4G. " => "donor_indicator", "5a. " => "driver_licence_no", "5b. " => "card_version_no", "7. " => "classes"}

     document = text.to_str
     driver_licence = Hash.new 
     document.each_line do |line|
        licence_variable.each do |licence_no, label|
            if line.include?(licence_no)
                data = line.split(licence_no)[1]
                licence_info = data.split(" ")[0]
                if label.include?("date")
                    driver_licence[label] = licence_info.gsub("-","/")
                else 
                    driver_licence[label] = licence_info
                end
            end 
        end
     end
     return driver_licence
  end
end
