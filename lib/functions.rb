def find_user(user_name)
    user= User.find_by(name: user_name)
end


def find_doctor(doctor_name)
    doctor = Doctor.find_by(name: doctor_name)
end


def find_favs_list
    user = find_user(@user_name)
    favs_list = Favorite.all.select{|favs_list| favs_list.user_id == user.id}
end


def userInfo
    user_name = $prompt.ask("Please enter your user name:")
    @user_name = user_name 
    if find_user(user_name)
        displayInfo(user_name)
    else
        puts "User name cannot be found.".red
        puts "Select option".cyan
        sign_up(user_name)
    end
end


def sign_up(user_name)
    list = ["Try again", "Create an account"]
    input = $prompt.select("*".green,list)

    case input
    when list[0]
        system "clear"
        userInfo
    when list[1]
        user_name= User.create(name: user_name).save
        userInfo
    end
end


<<<<<<< HEAD
def find_user(user_name)
    user= User.find_by(name: user_name)
end


def find_doctor(doctor_name)
    doctor = Doctor.find_by(name: doctor_name)
end


def find_favs_list
    user = find_user(@user_name)
    favs_list = Favorite.all.select{|favs_lists| favs_lists.user_id == user.id}
end


=======
>>>>>>> esther
def fav_list_view
    if find_favs_list != []
        large_table=Terminal::Table.new :title =>"#{@user_name}'s Favorites List".upcase.yellow, :style => {:width => 100, :padding_left => 3, :border_x => "=", :border_i => "="} do |t|
            doc = find_favs_list.map{|f| f.doctor_id}.uniq
            d_id = doc.each {|d| t << :separator
                t << [("#{Doctor.find_by(id: d).name}"),("#{Doctor.find_by(id: d).specialty.name} Medicine, Phone Number: #{Doctor.find_by(id: d).phone_number}")]
            }
        end
        puts " "
        puts large_table
    else
        puts "You don't have favorite list.".red
        puts " "
        task_menu
    end
end


def fav_list_table
    fav_list_view
    puts "Your Favorites List is shown above.".green
    puts " "
    task_menu
end
<<<<<<< HEAD
# binding.pry
=======


>>>>>>> esther
def add_fav_list(doctor)
    user = find_user(@user_name)
    
    if user.favorites.find{|favs| favs.doctor_id == doctor.id}
        puts " "
        puts "You already have in your Favorite's List".red
        puts " "
    else
        new_fav = Favorite.create(user_id: user.id, doctor_id: doctor.id)
        find_favs_list << new_fav
        doc = find_favs_list.map{|f| f.doctor_id}.uniq
        d_id = doc.each {|d| 
            find_favs_list << [("#{Doctor.find_by(id: d).name}"),("#{Doctor.find_by(id: d).specialty.name} Medicine, Phone Number: #{Doctor.find_by(id: d).phone_number}")]
        }
        fav_list_view
        puts " "
        puts "Updated Your Favorite's List is shown above.".cyan
        puts " "
    end
    task_menu
end

# d8.favorites.map{|favs| favs.user_id }
# u1.favorites.map{|favs| favs.doctor_id}
# binding.pry
def update_fav_list
    # find_favs_list


end


def delete_fav_list
    fav_list_view
    user = find_user(@user_name)
    doctor_name = $prompt.ask("Please enter your doctor name that you would like to delete.")
    doctor = find_doctor(doctor_name)
    if !doctor
        puts " "
        puts "Doctor's name cannot be found in favorite list.".red
        puts " "  

        list = ["Try again", "Go back to main menu"]
        input = $prompt.select("*".green,list)
    
        case input
        when list[0]
            system "clear"
            delete_fav_list
        when list[1]
            task_menu
        end
    
    else
        Favorite.find_by(user_id: user.id, doctor_id: doctor.id).delete
        fav_list_view
        puts " "
        puts "Your Favorite's List has been updated please review above".cyan
        puts " "
    end
    task_menu
end


def displayInfo(name)
    puts "Hi #{name}! Welcome to Doctor Finder!".cyan
    puts " "
end
