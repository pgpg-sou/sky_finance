
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

  def vehicle_apply
      render :layout => 'apply2'
  end

  def apply3
      render :layout => 'apply2'
  end

  def application_saver
      @application = params.to_json
      logger.debug "sample"
      logger.debug @application

    
      render :json => {"driver_licence" => @application}
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

        @driver_licence = driver_licence_crop(annotation.text)

        @word_data = Array.new
        prohabit_word_list = ["*", ".", "-", "NEW", "ZEALAND", "DRIVER", "LICENCE"]
        annotation.text.words.each do |word|
            if prohabit_word_list.include?(word.text) == false
                #logger.debug word.text
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

  def upload_driver_licence_back 
    uploaded_file = params[:file]
	output_path = Rails.root.join('public', uploaded_file.original_filename)
	
	File.open(output_path, 'w+b') do |fp|
	  fp.write  uploaded_file.read
	end

    vision = Google::Cloud::Vision.new(
        project: "46e9b8fc7d619db1971ff5d604b4858c5a95f33b",
        keyfile: Rails.root.to_s + "/lib/assets/spray-46e9b8fc7d61.json"
    )

    render :json => {"driver_licence" => @driver_licence.to_json, "words" => @word_data}
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
     visa_variable = {"Visa expiry:" => "expire_date", "Passport No: " => "passport_no", "Citizenship: " => "citizen_ship", "Sex:" => "gender" }
     visa_type = ["Student Visa", "Work Visa"]

     document = text.to_str
     visa_licence = Hash.new 
     hit_label = ""
     document.each_line do |line|
        logger.debug line.chomp
        if visa_type.include?(line.chomp)
            visa_licence["visa_type"] = line.chomp
        end
        if hit_label != ""
            visa_licence[hit_label] = line.to_s
            hit_label = ""
        end
        visa_variable.each do |licence_no, label|
            if line.include?(licence_no)
                data = line.split(licence_no)[1]
                licence_info = data.split(" ")[0]
                visa_licence[label] = licence_info
                if label == "expire_date" &&  visa_licence[label] == nil
                    hit_label = label
                end
            end 
        end
     end
     puts visa_licence
     return visa_licence
  end


  def driver_licence_back_crop(text)
     licence_keyword = {"Surname" => "last_name", "First Names" => "first_name", "Date of birth" => "birth_date", "Licence" => "driver_licence_no", "Version" => "card_version_no"}

     document = text.to_str
     driver_licence = Hash.new 

     hit_label = ""
     document.each_line do |line|
        puts line.to_s

        if hit_label != ""
            driver_licence[hit_label] = line.to_s
            hit_label = ""
        end
        
        licence_keyword.each do |keyword, label|
        end
     end
     puts driver_licence
     return driver_licence
  end


  def driver_licence_crop(text)
     licence_variable = {"1. " => "last_name", "2. " => "first_name", "3. " => "birth_date", "4a. " => "issue_date", "4b. " => "expire_date", "4G. " => "donor_indicator", "5a. " => "driver_licence_no", "5b. " => "card_version_no", "7. " => "classes"}
     licence_keyword = {"Surname" => "last_name", "First Names" => "first_name", "Date of birth" => "birth_date", "Licence" => "driver_licence_no", "Version" => "card_version_no"}
     licence_country = {"NEW ZEALAND" => "NZL"}
     licence_type = ["RESTRICTED", "LEARNER"]

     ignore_keyword=["NEW ZEALAND", "RESTRICTED", "LEARNER", "DRIVER IDENTITY"]

     document = text.to_str
     driver_licence = Hash.new 

     hit_label = ""
     document.each_line do |line|
        puts line.to_s
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
        if hit_label != ""
            is_ignore = true
            ignore_keyword.each do |ignore|
                if line.to_s.include?(ignore)
                    is_ignore = false
                end
            end
            if is_ignore
                driver_licence[hit_label] = line.to_s
                hit_label = ""
            else
            end
        end
        
        licence_keyword.each do |keyword, label|
            if line.to_s.strip == keyword || line.include?(keyword)
                if keyword == "Date of birth"
                    data = line.split(keyword)[1]
                    driver_licence[label] = data.strip.gsub('-','/')
                elsif keyword == "Licence"
                    d = line.chomp.split(' ')
                    index = d.index(keyword)
                    driver_licence[label] = d[index+1]
                elsif keyword == "Version"
                    d = line.chomp.split(' ')
                    index = d.index(keyword)
                    driver_licence[label] = d[index+1]
                else
                    hit_label = label
                end
            end
        end
        licence_country.each do |keyword, label|
            if line.to_s.include?(keyword) 
                driver_licence["licence_country"] = label
            end
        end

        licence_type.each do |type|
            if line.to_s.include?(type)
                driver_licence["licence_type"] = type 
            end
        end


     end
     puts driver_licence
     return driver_licence
  end
end
