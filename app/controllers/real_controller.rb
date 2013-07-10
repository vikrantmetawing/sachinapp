class RealController < ApplicationController
	  def crm_leads_view 
	connection = ActiveRecord::Base.connection();
	
		#@t=connection.execute("select t.l_id,t.property_id,t.req_no,t.leads_type,t.leads_type,t.remark,t.created_at,t.user_id,t.property_name,t.name ,t.phone,t.property_type ,t.sub_property_type,t.r_sub_property_type from (select * from (select l.*,users_"+session[:master_user_id].to_s+".name,users_"+session[:master_user_id].to_s+".phone  from  ( SELECT leads_"+session[:master_user_id].to_s+".* ,properties_"+session[:master_user_id].to_s+".* FROM leads_"+session[:master_user_id].to_s+" LEFT OUTER JOIN properties_"+session[:master_user_id].to_s+" ON leads_"+session[:master_user_id].to_s+".property_id=properties_"+session[:master_user_id].to_s+".property_id)as l LEFT OUTER JOIN users_"+session[:master_user_id].to_s+" ON l.user_id=users_"+session[:master_user_id].to_s+".sub_user_id) as r LEFT OUTER JOIN contactmail_"+session[:master_user_id].to_s+" ON r.req_no=contactmail_"+session[:master_user_id].to_s+".r_req_no)as t ;")
		@t=connection.execute("select t.l_id,t.property_id,t.req_no,t.leads_type,t.leads_type,t.remark,t.created_at,t.user_id,t.property_name,t.name ,t.phone,t.property_type ,t.sub_property_type,t.r_sub_property_type from (select a.*,users_"+session[:master_user_id].to_s+".*,contactmail_"+session[:master_user_id].to_s+".*,properties_"+ session[:master_user_id].to_s+".property_name,properties_"+session[:master_user_id].to_s+".price,properties_"+session[:master_user_id].to_s+".state,properties_"+session[:master_user_id].to_s+".property_type,properties_"+session[:master_user_id].to_s+".purpose,properties_"+session[:master_user_id].to_s+".bedroom,properties_"+session[:master_user_id].to_s+".image,properties_"+session[:master_user_id].to_s+".sub_property_type from leads_"+session[:master_user_id].to_s+" a LEFT OUTER JOIN users_"+session[:master_user_id].to_s+" on a.user_id = users_"+session[:master_user_id].to_s+".sub_user_id   LEFT OUTER JOIN properties_"+session[:master_user_id].to_s+"  on a.property_id=properties_"+session[:master_user_id].to_s+".property_id LEFT OUTER JOIN contactmail_"+session[:master_user_id].to_s+" on contactmail_"+session[:master_user_id].to_s+".r_req_no=a.req_no)as t; ")
	
		if params[:commit] == "goo" then
	
	
			#@s="select t.l_id,t.property_id,t.req_no,t.leads_type,t.leads_type,t.remark,t.created_at,t.user_id,t.property_name,t.name ,t.phone,t.property_type ,t.sub_property_type,t.r_sub_property_type from (select * from (select l.*,users_"+session[:master_user_id].to_s+".name,users_"+session[:master_user_id].to_s+".phone  from  ( SELECT leads_"+session[:master_user_id].to_s+".* ,properties_"+session[:master_user_id].to_s+".* FROM leads_"+session[:master_user_id].to_s+" LEFT OUTER JOIN properties_"+session[:master_user_id].to_s+" ON leads_"+session[:master_user_id].to_s+".property_id=properties_"+session[:master_user_id].to_s+".property_id)as l LEFT OUTER JOIN users_"+session[:master_user_id].to_s+" ON l.user_id=users_"+session[:master_user_id].to_s+".sub_user_id) as r LEFT OUTER JOIN contactmail_"+session[:master_user_id].to_s+" ON r.req_no=contactmail_"+session[:master_user_id].to_s+".r_req_no)as t where "
			@s="select t.l_id,t.property_id,t.req_no,t.leads_type,t.leads_type,t.remark,t.created_at,t.user_id,t.property_name,t.name ,t.phone,t.property_type ,t.sub_property_type,t.r_sub_property_type from (select a.*,users_1.*,contactmail_1.*,properties_"+ session[:master_user_id].to_s+".property_name,properties_"+session[:master_user_id].to_s+".price,properties_"+session[:master_user_id].to_s+".state,properties_"+session[:master_user_id].to_s+".property_type,properties_"+session[:master_user_id].to_s+".purpose,properties_"+session[:master_user_id].to_s+".bedroom,properties_"+session[:master_user_id].to_s+".image,properties_"+session[:master_user_id].to_s+".sub_property_type from leads_"+session[:master_user_id].to_s+" a LEFT OUTER JOIN users_"+session[:master_user_id].to_s+" on a.user_id = users_"+session[:master_user_id].to_s+".sub_user_id   LEFT OUTER JOIN properties_"+session[:master_user_id].to_s+"  on a.property_id=properties_"+session[:master_user_id].to_s+".property_id LEFT OUTER JOIN contactmail_"+session[:master_user_id].to_s+" on contactmail_"+session[:master_user_id].to_s+".r_req_no=a.req_no)as t where "
			if params[:source_intrested] == "interested" then
			@s= @s + "t.property_id !=0 and  "
			end
			if params[:source_requirment] == "requirement" then
			@s= @s + "t.req_no !=0 and  "
			end
			
			if params[:source_offline] == "offline" 
			
			end
			
			
			if params[:gender]== "residential" then
			@s= @s + "t.property_type ='residential' or t.r_property_type ='residential' and "
			
			end
			
			if params[:gender] =="industrial" then
			@s= @s + "t.property_type ='Industrial' or t.r_property_type ='industrial'  and "	
			end
			
			if params[:gender] == "land" then
			@s= @s + "t.property_type ='land' or t.r_property_type ='land'  and  "	
			end
			if params[:gender] == "commercial" then
			@s= @s + "t.property_type ='Commercial' or t.r_property_type ='Commercial' and  "	
			end
			if params[:budget_from] != "from" and params[:budget_to] != "to" then
			
			@s= @s+ "t.price BETWEEN " + params[:budget_from].to_s + " AND " + params[:budget_to].to_s + " or  t.r_price_limit BETWEEN " + params[:budget_from].to_s + " AND " + params[:budget_to].to_s + " and "	
			end	
			if params[:city] != "city" then
			@s= @s + "t.state = "+"\'" + params[:city].to_s + "\'" + " or t.r_location="+"\'" +params[:city].to_s + "\'" + " and "
			" and  "
			end
			if params[:status_initial] == "Initial" then
			@s= @s + "t.leads_type = 'initial' and  "
			end
			if params[:status_inprogress] == "In progress" then
			@s= @s + "t.leads_type = 'inprogress' and  "
			end
			
			if params[:status_prospected] == "Prospected" 
			@s= @s + "t.leads_type = 'prospected' and  "
			end
			if params[:status_client] == "Client" 
			@s= @s + "t.leads_type = 'client' and  "
			end
			if params[:status_closed] == "Closed" 
			@s= @s + "t.leads_type = 'closed' and  "
			end
			if params[:user_id] != "user id" 
			@s= @s + "t.user_id = "+"\'" + params[:user_id].to_s + "\'" + " and  "
			end
			if params[:property_id] != "property id" 
			@s= @s + "t.property_id = "+"\'" + params[:property_id].to_s + "\'" +  " and  "
			end
			@test=params[:budget_to]
			@s=@s +" 1=1"
			#@s=params[:city]
			@t=connection.execute(@s);
		end
			
	
	
	end	
	
	
	

	def crm_leads_delete
			connection = ActiveRecord::Base.connection();
			@t=connection.execute("DELETE FROM leads_" +session[:master_user_id].to_s+ " WHERE l_id=" +params[:l_id])
			
			if params[:req_no] != '0' then  
				@t=connection.execute("DELETE FROM contactmail_" +session[:master_user_id].to_s+ " WHERE r_req_no=" +params[:req_no])
			end
			redirect_to :controller=>session[:master_user_name], :action => 'crm_leads_view'
	end
	def crm_user
	
			connection = ActiveRecord::Base.connection();
			@t=connection.execute("select * from users_"+session[:master_user_id].to_s+" where sub_user_id=1")
			
		
	end
	
	def crm_leads_save
		
			connection = ActiveRecord::Base.connection();
		
		case params[:status][:type]
					when '1'
						
					when '2'
						status= "Initial"
					when '3'
						status=   "In progress"
					
					when '4'
						status= "Prospected"
					when '5'
						status= "Client"
					when '6'
						status= "Closed"
						
				end
			connection.execute("update leads_"+session[:master_user_id].to_s+" set remark="+"\"" + params[:remark] + "\""+" ,leads_type=" +"\"" + status+"\"" + " where l_id=" +params[:l_id])
			
			
			redirect_to :controller=>session[:master_user_name], :action => 'crm_leads_view'
	end
	 def contactmail
               if params[:commit] == "send" then
                               Properties.find_by_sql(["INSERT INTO contactmail_"+session[:master_user_id].to_s+"(r_name,r_email,r_phone,r_property_type,r_sub_property_type,r_purpose,r_bed_room,r_price_limit,r_location,r_user_id) VALUES (?,?,?,?,?,?,?,?,?,?)" ,params[:name],params[:email],params[:phone],params[:propertytype],params[:subpropertytype],params[:purpose],params[:bedroom],params[:price],params[:location],$user_id])
                               connection = ActiveRecord::Base.connection();
							  t=connection.execute("select max(r_req_no) from contactmail_"+session[:master_user_id].to_s);
							   Properties.find_by_sql(["INSERT INTO leads_"+session[:master_user_id].to_s+"(user_id,req_no,created_at ) VALUES (?,?,?)" ,session[:userid],t[0]["max(r_req_no)"],Time.now.strftime("%m/%d/%Y")])
                               
                              UserMailer.req(session[:c_email],params[:name],params[:email],params[:phone],params[:propertytype],params[:subpropertytype],params[:purpose],params[:bedroom],params[:price],params[:location]).deliver
                               flash[:notice] = "#{'We accept your request,we will contact you '}"
                              #redirect_to :action => 'home'
							  redirect_to :action => 'contact'
                       end
       end
 
		def adminhome_edit
               
		   #@a=params[:id]
		   @t=Home.find_by_sql(["select * from homes where user_id = ?  ", session[:master_user_id]])
		   
		   
		   #render :layout => "adminhome"
       end
		
	
	def master_signup 
			if params[:commit] == "upload" then
					if (MasterUsers.last).blank? then 
						a=0
					else
					a = ((MasterUsers.last).master_user_id)
	
					end

					if a == 'nil' then
						a = 0
					end
					a += 1
					if params[:password] == params[:confirmpassword] then
						 MasterUsers.create(:master_user_id => a,:shop_name => params[:name],:password=>params[:password],:master_email=>params[:email])
						 UserMailer.master_welcome_email( a,params[:name],params[:password],params[:email]).deliver
						 
					end
					flash[:notice] = "#{'Your account created successfully and your user id  =' + a.to_s()}"
					redirect_to :action => 'fst'
				end
			
	end
	
	def fst
		render :layout => "front"
	end
	def s
	connection = ActiveRecord::Base.connection();

	
	end
	
		def basic_view
		
							#session[:master_user_id]=(MasterUsers.find_by_shop_name(params[:id])).master_user_id
							if params[:name]=="master_user_validate"
							   #session[:master_user_id]=(Home.find_by_c_name(params[:id])).user_id
								
								session[:userflag]="false"
								h_detail=Home.find_by_user_id(session[:master_user_id])
								c_detail=MContact.find_by_user_id(session[:master_user_id])
								s_detail=MStories.find_by_user_id(session[:master_user_id])
								session[:slider_1]=h_detail.slider_img_1
								session[:slider_2]=h_detail.slider_img_2
								session[:slider_3]=h_detail.slider_3
								session[:logo]=h_detail.logo
								session[:company_image_1]=h_detail.c_img_1
								session[:company_image_2]=h_detail.c_img_2
								session[:company_name]=h_detail.c_name
								session[:address]=h_detail.address
								session[:phone]=h_detail.phone
								session[:c_contant]=c_detail.contant
								session[:c_email]=c_detail.email
								session[:s_contant]=s_detail.contant
								#redirect_to :action => 'home'
								 redirect_to :controller=>session[:master_user_name], :action => 'home'
							end
						
						if params[:name] != "master_user_validate"
						
							if (MasterUsers.find_by_shop_name(params[:id]).nil?) then 
								flash[:notice] = "#{'ERROR: There  is no shop with this name ' }"
								session[:userflag]="false"
								redirect_to  :action => 's'
								#redirect_to :action => 'home'
							
							else 
						
							session[:userflag]="false"
							session[:masterflag]="false" 
							session[:master_user_id]=(MasterUsers.find_by_shop_name(params[:id])).master_user_id
							session[:master_user_id]=(MasterUsers.find_by_shop_name(params[:id])).master_user_id
							session[:master_user_name]=(MasterUsers.find_by_shop_name(params[:id])).shop_name
							#session[:master_user_name]=(MasterUsers.find_by_shop_name("rajat")).shop_name
							h_detail=Home.find_by_user_id(session[:master_user_id])
							c_detail=MContact.find_by_user_id(session[:master_user_id])
							s_detail=MStories.find_by_user_id(session[:master_user_id])
							session[:slider_1]=h_detail.slider_img_1
							session[:slider_2]=h_detail.slider_img_2
							session[:slider_3]=h_detail.slider_3
							session[:logo]=h_detail.logo
							session[:company_image_1]=h_detail.c_img_1
							session[:company_image_2]=h_detail.c_img_2
							session[:company_name]=h_detail.c_name
							session[:address]=h_detail.address
							session[:phone]=h_detail.phone
							session[:c_contant]=c_detail.contant
							session[:c_email]=c_detail.email
							session[:s_contant]=s_detail.contant
							#redirect_to :action => 'home'
							 redirect_to :controller=>session[:master_user_name], :action => 'home'
							end
						end	
		end
		def x
		
	connection = ActiveRecord::Base.connection();
			#@results = connection.execute("ALTER contactpeople mytable ALTER COLUMN phone string")
			
			#s="CREATE TABLE "+ "properties_5"+"(property_id INTEGER PRIMARY KEY AUTOINCREMENT,property_name varchar(255),price varchar(255),state varchar(255),property_type varchar(255),purpose varchar(255),bedroom int,image varchar(255),sub_property_type varchar(255),contant varchar(255),created_at datetime,updated_at datetime)"
			connection.execute(s)
	end
		
		def admin_contact
		if params[:commit] == "upload" then
					contant=params[:contant]
					email=params[:email]
				 User.find_by_sql(["UPDATE m_contacts SET contant=?,email=? WHERE user_id=?",contant,email,session[:userid]])	
				# Storiess.create(:name =>params[:name],:email =>params[:email],:story =>params[:story],:image =>@path1,:phone=>params[:phone],:user_id=>@a)
							c_detail=MContact.find_by_user_id(session[:master_user_id])
							session[:c_contant]=c_detail.contant
							session[:c_email]=c_detail.email
							
			#redirect_to :action => 'contact'
			 redirect_to :controller=>session[:master_user_name], :action => 'contact'
			end
		end
		def admin_stories
		if params[:commit] == "upload" then
					contant=params[:contant]
					
				 User.find_by_sql(["UPDATE m_stories SET contant=? WHERE user_id=?",contant,session[:master_user_id]])	
				# Storiess.create(:name =>params[:name],:email =>params[:email],:story =>params[:story],:image =>@path1,:phone=>params[:phone],:user_id=>@a)
							s_detail=MStories.find_by_user_id(session[:master_user_id])
							session[:s_contant]=s_detail.contant
			#redirect_to :action => 'story'
			 redirect_to :controller=>session[:master_user_name], :action => 'story'
			end
		end
		
		
		def admin_home
		
		if params[:commit]=="save name" then 
				
			
				 User.find_by_sql(["UPDATE homes SET c_name=? WHERE user_id=?",params[:name],session[:master_user_id]])	
				h_detail=Home.find_by_user_id(session[:master_user_id])
							
							
							session[:company_name]=h_detail.c_name
							
				redirect_to :controller=>session[:master_user_name], :action => 'home'
				
		end
		
		if params[:commit]=="testsubmit" then 
				if !params[:upload4].blank?
				name = params[:upload4][:file4].original_filename
				directory = "public/images/"
				@path = File.join(directory, name)
				File.open(@path, "wb") { |f| f.write(params[:upload4][:file4].read) }
				flash[:notice] = "File uploaded"
				logo = File.join("/images/", name)
				end
				
				 User.find_by_sql(["UPDATE homes SET logo=? WHERE user_id=?",logo,session[:master_user_id]])	
				h_detail=Home.find_by_user_id(session[:master_user_id])
							
							
							session[:logo]=h_detail.logo
							
				redirect_to :controller=>session[:master_user_name], :action => 'home'
				
		end
		if params[:commit]=="slider_1" then 
				if !params[:upload1].blank?
				name = params[:upload1][:file1].original_filename
				directory = "public/images/"
				@path = File.join(directory, name)
				File.open(@path, "wb") { |f| f.write(params[:upload1][:file1].read) }
				flash[:notice] = "File uploaded"
				slider_1 = File.join("/images/", name)
				end
				
				 User.find_by_sql(["UPDATE homes SET slider_img_1=? WHERE user_id=?",slider_1,session[:master_user_id]])	
				h_detail=Home.find_by_user_id(session[:master_user_id])
							
							
							session[:slider_1]=h_detail.slider_img_1
							
				redirect_to :controller=>session[:master_user_name], :action => 'home'
				
		end
		if params[:commit]=="slider_2" then 
				if !params[:upload2].blank?
				name = params[:upload2][:file2].original_filename
				directory = "public/images/"
				@path = File.join(directory, name)
				File.open(@path, "wb") { |f| f.write(params[:upload2][:file2].read) }
				flash[:notice] = "File uploaded"
				slider_2 = File.join("/images/", name)
				end
				
				 User.find_by_sql(["UPDATE homes SET slider_img_2=? WHERE user_id=?",slider_2,session[:master_user_id]])	
				h_detail=Home.find_by_user_id(session[:master_user_id])
							
							
							session[:slider_2]=h_detail.slider_img_2
							
				redirect_to :controller=>session[:master_user_name], :action => 'home'
				
		end
		if params[:commit]=="slider_3" then 
				if !params[:upload3].blank?
				name = params[:upload3][:file3].original_filename
				directory = "public/images/"
				@path = File.join(directory, name)
				File.open(@path, "wb") { |f| f.write(params[:upload3][:file3].read) }
				flash[:notice] = "File uploaded"
				slider_3 = File.join("/images/", name)
				end
				 User.find_by_sql(["UPDATE homes SET slider_3=? WHERE user_id=?",slider_3,session[:master_user_id]])	
				h_detail=Home.find_by_user_id(session[:master_user_id])
							
							
							session[:slider_3]=h_detail.slider_3
							
				redirect_to :controller=>session[:master_user_name], :action => 'home'
				
		end
		
		
		if params[:commit]=="cancle" then
		h_detail=Home.find_by_user_id(session[:master_user_id])
							
							session[:slider_1]=h_detail.slider_img_1
							session[:slider_2]=h_detail.slider_img_2
							session[:slider_3]=h_detail.slider_3
							session[:logo]=h_detail.logo
							session[:company_image_1]=h_detail.c_img_1
							session[:company_image_2]=h_detail.c_img_2
							session[:company_name]=h_detail.c_name
							session[:address]=h_detail.address
							session[:phone]=h_detail.phone
							
		end
		
		if params[:commit] == "submit" then
				
				if !params[:upload1].blank?
				name = params[:upload1][:file1].original_filename
				directory = "public/images/"
				@path = File.join(directory, name)
				File.open(@path, "wb") { |f| f.write(params[:upload1][:file1].read) }
				flash[:notice] = "File uploaded"
				slider_1 = File.join("/images/", name)
				end
				if !params[:upload2].blank?
				name = params[:upload2][:file2].original_filename
				directory = "public/images/"
				@path = File.join(directory, name)
				File.open(@path, "wb") { |f| f.write(params[:upload2][:file2].read) }
				flash[:notice] = "File uploaded"
				slider_2 = File.join("/images/", name)
				end
				if !params[:upload3].blank?
				name = params[:upload3][:file3].original_filename
				directory = "public/images/"
				@path = File.join(directory, name)
				File.open(@path, "wb") { |f| f.write(params[:upload3][:file3].read) }
				flash[:notice] = "File uploaded"
				slider_3 = File.join("/images/", name)
				end
				if !params[:upload4].blank?
				name = params[:upload4][:file4].original_filename
				directory = "public/images/"
				@path = File.join(directory, name)
				File.open(@path, "wb") { |f| f.write(params[:upload4][:file4].read) }
				flash[:notice] = "File uploaded"
				logo = File.join("/images/", name)
				end
				if !params[:upload5].blank?
				name = params[:upload5][:file5].original_filename
				directory = "public/images/"
				@path = File.join(directory, name)
				File.open(@path, "wb") { |f| f.write(params[:upload5][:file5].read) }
				flash[:notice] = "File uploaded"
				company_image_1 = File.join("/images/", name)
				end
				if !params[:upload6].blank?
				name = params[:upload6][:file6].original_filename
				directory = "public/images/"
				@path = File.join(directory, name)
				File.open(@path, "wb") { |f| f.write(params[:upload6][:file6].read) }
				flash[:notice] = "File uploaded"
				company_image_2 = File.join("/images/", name)
				end
					company_name=params[:name]
					address=params[:email]
					phone=params[:phone]
					about_us=params[:story]
				 User.find_by_sql(["UPDATE homes SET c_name=?,phone=?,address=?,logo=?,slider_img_1=?,slider_img_2=?,slider_3=?,c_img_1=?,c_img_2=? WHERE user_id=?",company_name,phone,address,logo,slider_1,slider_2,slider_3,company_image_1,company_image_2,session[:master_user_id]])	
				# Storiess.create(:name =>params[:name],:email =>params[:email],:story =>params[:story],:image =>@path1,:phone=>params[:phone],:user_id=>@a)
							h_detail=Home.find_by_user_id(session[:master_user_id])
							
							session[:slider_1]=h_detail.slider_img_1
							session[:slider_2]=h_detail.slider_img_2
							session[:slider_3]=h_detail.slider_3
							session[:logo]=h_detail.logo
							session[:company_image_1]=h_detail.c_img_1
							session[:company_image_2]=h_detail.c_img_2
							session[:company_name]=h_detail.c_name
							session[:address]=h_detail.address
							session[:phone]=h_detail.phone
							
			#redirect_to :action => 'home'
			redirect_to :controller=>session[:master_user_name], :action => 'home'
			end
			if params[:commit]=="preview"
				if !params[:upload1].blank?
				name = params[:upload1][:file1].original_filename
				directory = "public/images/"
				@path = File.join(directory, name)
				File.open(@path, "wb") { |f| f.write(params[:upload1][:file1].read) }
				flash[:notice] = "File uploaded"
				slider_1 = File.join("/images/", name)
				end
				if !params[:upload2].blank?
				name = params[:upload2][:file2].original_filename
				directory = "public/images/"
				@path = File.join(directory, name)
				File.open(@path, "wb") { |f| f.write(params[:upload2][:file2].read) }
				flash[:notice] = "File uploaded"
				slider_2 = File.join("/images/", name)
				end
				if !params[:upload3].blank?
				name = params[:upload3][:file3].original_filename
				directory = "public/images/"
				@path = File.join(directory, name)
				File.open(@path, "wb") { |f| f.write(params[:upload3][:file3].read) }
				flash[:notice] = "File uploaded"
				slider_3 = File.join("/images/", name)
				end
				if !params[:upload4].blank?
				name = params[:upload4][:file4].original_filename
				directory = "public/images/"
				@path = File.join(directory, name)
				File.open(@path, "wb") { |f| f.write(params[:upload4][:file4].read) }
				flash[:notice] = "File uploaded"
				logo = File.join("/images/", name)
				end
				if !params[:upload5].blank?
				name = params[:upload5][:file5].original_filename
				directory = "public/images/"
				@path = File.join(directory, name)
				File.open(@path, "wb") { |f| f.write(params[:upload5][:file5].read) }
				flash[:notice] = "File uploaded"
				company_image_1 = File.join("/images/", name)
				end
				if !params[:upload6].blank?
				name = params[:upload6][:file6].original_filename
				directory = "public/images/"
				@path = File.join(directory, name)
				File.open(@path, "wb") { |f| f.write(params[:upload6][:file6].read) }
				flash[:notice] = "File uploaded"
				company_image_2 = File.join("/images/", name)
				end
					company_name=params[:name]
					address=params[:email]
					phone=params[:phone]
					about_us=params[:story]
				# User.find_by_sql(["UPDATE homes SET c_name=?,phone=?,address=?,logo=?,slider_img_1=?,slider_img_2=?,slider_3=?,c_img_1=?,c_img_2=? WHERE user_id=?",company_name,phone,address,logo,slider_1,slider_2,slider_3,company_image_1,company_image_2,session[:master_user_id]])	
				# Storiess.create(:name =>params[:name],:email =>params[:email],:story =>params[:story],:image =>@path1,:phone=>params[:phone],:user_id=>@a)
			#h_detail=Home.find_by_user_id(session[:master_user_id])
							
							session[:slider_1]=slider_1
							session[:slider_2]=slider_2
							session[:slider_3]=slider_3
							session[:logo]=logo
							session[:company_image_1]=company_image_1
							session[:company_image_2]=company_image_2
							session[:company_name]=company_name
							session[:address]=address
							session[:phone]=phone
							
			#redirect_to :action => 'home'
			redirect_to :controller=>session[:master_user_name], :action => 'previewhome'	
		end
		end
		
		def previewhome
		
		
		
		
		if params[:commit]=="Save" then 
		 User.find_by_sql(["UPDATE homes SET c_name=?,phone=?,address=?,logo=?,slider_img_1=?,slider_img_2=?,slider_3=?,c_img_1=?,c_img_2=? WHERE user_id=?",session[:company_name],session[:phone],session[:address],session[:logo],session[:slider_1],session[:slider_2],session[:slider_3],$company_img_1,$company_img_2,session[:master_user_id]])	
			redirect_to :controller=>session[:master_user_name], :action => 'adminhome'	
		end
		end
		
		
	
		
	
		def test
		@a =Home.all
		@b=MContact.all	
		@c=MStories.all
		@d=MasterUsers.all
		connection = ActiveRecord::Base.connection();
   		
		
					@t=connection.execute("SELECT user_id FROM homes")
	
					@t=@t[0]["user_id"]




		end
		def user_validate
		
            connection = ActiveRecord::Base.connection();
   		
		
		 User.find_by_sql(["UPDATE users_" +session[:master_user_id].to_s + " SET validates=? WHERE sub_user_id=?",true,params[:uid]])
		#redirect_to :action => 'userlogin'
		 redirect_to :controller=>session[:master_user_name], :action => 'userlogin'
		end
		
		def master_user_validate
			session[:master_user_id]=params[:uid]	
			session[:master_user_name]=params[:shopname]
			Home.create(:user_id=>params[:uid],:c_name=>params[:shopname],:phone=>"0000000000000",:address=>"Company Address ",:logo=>"/images/01.jpg",:slider_img_1=>"/images/01.jpg",:slider_img_2=>"/images/01.jpg",:slider_3=>"/images/01.jpg",:c_img_1=>"/images/01.jpg",:c_img_2=>"/images/01.jpg") 
			MContact.create(:user_id =>params[:uid],:contant=>"Write some conatnt for your user",:email=>"sachinsingh.7903@gmail.com")
			MStories.create(:user_id =>params[:uid],:contant=>"Write some conatnt for your user")	
			connection = ActiveRecord::Base.connection();
			#@results = connection.execute("ALTER contactpeople mytable ALTER COLUMN phone string")
			s="CREATE TABLE "+ "contactpeople_"+session[:master_user_id].to_s+"(name varchar(100),email varchar(255),phone varchar(255),message varchar(255))"
			connection.execute(s)
			s="CREATE TABLE "+ "properties_"+session[:master_user_id].to_s+"(property_id SERIAL NOT NULL PRIMARY KEY,property_name varchar(255),price varchar(255),state varchar(255),property_type varchar(255),purpose varchar(255),bedroom int,image varchar(255),sub_property_type varchar(255),contant varchar(255),created_at date,updated_at date)"
			connection.execute(s)
			s="CREATE TABLE "+ "storiesses_"+session[:master_user_id].to_s+"(story_id  SERIAL NOT NULL PRIMARY KEY,sub_user_id int,name varchar(100),email varchar(255),phone varchar(255),story varchar(255),image varchar(2))"
			connection.execute(s)
			s="CREATE TABLE "+ "users_"+session[:master_user_id].to_s+"( sub_user_id  SERIAL NOT NULL PRIMARY KEY ,phone varchar(20),name varchar(100),password varchar(255),my_properties varchar(255),email varchar(255),validates boolean )"
			connection.execute(s)
			s="CREATE TABLE "+ "contactmail_"+session[:master_user_id].to_s+"(r_req_no  SERIAL NOT NULL PRIMARY KEY,r_name varchar(100),r_email varchar(255),r_phone varchar(255),r_property_type varchar(255),r_sub_property_type varchar(255),r_purpose varchar(255),r_bed_room varchar(255),r_price_limit varchar(255),r_location varchar(255),r_user_id integer)"
			connection.execute(s)
			s="CREATE TABLE "+ "leads_"+session[:master_user_id].to_s+"(l_id SERIAL NOT NULL PRIMARY KEY,user_id integer ,property_id integer DEFAULT '0',req_no integer DEFAULT '0',leads_type varchar(50) DEFAULT 'initial',created_at date,remark varchar(1000) DEFAULT '')"
			connection.execute(s)
 
			
			  MasterUsers.find_by_sql(["UPDATE master_users SET validate=? WHERE master_user_id=?",true,params[:uid]])
			#redirect_to :action =>'basic_view',:name=>"master_user_validate"	
			 redirect_to :controller=>session[:master_user_name], :action => 'basic_view',:name=>"master_user_validate"
			
		end
		
		def property
		end
		 def proplist
       
              
               if params[:name]=="deleteproperty"
			   connection = ActiveRecord::Base.connection();
					t=connection.execute("select my_properties from users_" +session[:master_user_id].to_s + " where sub_user_id ="+ session[:userid].to_s)
                       @x=t[0]["my_properties"]
                       @a = @x
                       @dl = params[:p_id].to_s
                      
                       if @x != nil then
                                        @a.slice! params[:p_id]+","          
                       end
                       User.find_by_sql(["UPDATE users_" + session[:master_user_id].to_s+ " SET my_properties=? WHERE sub_user_id=?",@a,session[:userid]])
                               flash[:notice] = "#{'This property is deleted from your list sucessfully' }"
                        #redirect_to :action => 'homesearch',:name=>"delete"
                        redirect_to :controller=>session[:master_user_name], :action => 'homesearch',:name=>"delete"
               end
               
               if params[:name]=="admindeleteproperty"
                       Properties.find_by_sql(["DELETE FROM properties_" + session[:master_user_id].to_s+ " WHERE property_id= ?",[params[:p_id]]])
						flash[:notice] = "#{'This property is deleted from your database' }"   
						#redirect_to :action => 'search',:name=>"delete"
						redirect_to :controller=>session[:master_user_name], :action => 'search',:name=>"delete"						
			  end
       
              
       end
		 def adminstorydelete
       
               if params[:name] == "deletestory"
			    connection = ActiveRecord::Base.connection();
				    Properties.find_by_sql("DELETE FROM storiesses_" +session[:master_user_id].to_s + "  WHERE story_id="+ params[:s_id].to_s)
              # redirect_to :action => 'story'
               redirect_to :controller=>session[:master_user_name], :action => 'story'
               
               end
       end
		def usersignup
			if params[:commit]=="Submit" then
				if params[:password]==params[:confirmpassword] then 
				    connection = ActiveRecord::Base.connection();
				    Properties.find_by_sql(["INSERT INTO users_"+session[:master_user_id].to_s+"(name,password,email) VALUES (?,?,?)",params[:name],params[:password],params[:email]])
					
					@t=connection.execute("SELECT sub_user_id FROM users_" +session[:master_user_id].to_s+ " WHERE sub_user_id=(SELECT MAX(sub_user_id) FROM users_"+ session[:master_user_id].to_s+" )")
					UserMailer.welcome_email(@t[0]["sub_user_id"],params[:name],params[:password],params[:email]).deliver
					flash[:notice] = "#{'your account is created sucessfully details send to your EMail Id and your login id is = '+ @t[0]["sub_user_id"].to_s }"	
					#redirect_to :action => 'userlogin'
					 redirect_to :controller=>session[:master_user_name], :action => 'userlogin'
				else 
					flash[:notice] = "#{'confirm password and Password not match'}"		
				end
			end
		end
		
		def userlogin	
		
			if params[:commit]== "login" then
			connection = ActiveRecord::Base.connection();
			 #@t= "select * from properties_" + session[:master_user_id].to_s+ " where sub_user_id = "+params[:loginid]
			member=connection.execute("select * from users_" + session[:master_user_id].to_s+ " where sub_user_id = "+params[:loginid])	
	#$t=connection.execute("select * from users_34")

				if member != nil then
				
					if   member[0]["password"]==params[:password]
						if member[0]["validates"]=="t" then
							session[:userid]=params[:loginid]
							session[:userflag]="true"
							
							 redirect_to :controller=>session[:master_user_name], :action => 'home'
							#redirect_to :action => 'home'
						else
							flash[:notice] = "#{'you need to varify your Email id before login'}"					
							#redirect_to :action => 'userlogin'
							 redirect_to :controller=>session[:master_user_name], :action => 'userlogin'
						end
					else
						flash[:notice] = "#{'Invalid Login and Password details'}"					
						#redirect_to :action => 'userlogin'
						 redirect_to :controller=>session[:master_user_name], :action => 'userlogin'
					end
				else
				flash[:notice] = "#{'Please enter details properly'}"					
							#redirect_to :action => 'userlogin'
							 redirect_to :controller=>session[:master_user_name], :action => 'userlogin'
				end		
			end
							
			
			
			
			
		end
		
		def admin_property_view
			#@t=Properties.all
			connection = ActiveRecord::Base.connection();
			@t=connection.execute("select * from properties_"+session[:master_user_id].to_s)
		end
		
		def property_add
		#@test=(["insert into properties (name, email, phone, story,created_at,updated_at) values (?,?,?,?,?,?)",[$x],[$y],[$z],[$p],[$q],[$r]])
			
			if params[:commit] == "upload" then
				if !params[:upload].blank?
				name = params[:upload][:file].original_filename
				directory = "public/images/"
				@path = File.join(directory, name)
				File.open(@path, "wb") { |f| f.write(params[:upload][:file].read) }
				flash[:notice] = "File uploaded"
				@path1 = File.join("/images/", name)
				
				
				end
				case params[:property_type][:item_type]
					when '1'
						property_type=""
					when '2'
					property_type="Commercial"
						
					when '3'
						property_type="Industrial"
						
					when '4'
					property_type="Land"
						
					when '5'
					property_type="Residential"
						
				end
				case params[:sub_property_type][:item_type]
					when '1'
						sub_property_type=""
					when '2'
					sub_property_type="Condo"
						
					when '3'
						sub_property_type="Appartment"
						
					when '4'
					sub_property_type="Duplex"
						
					when '5'
					sub_property_type="Triplex"
						
				end
				case params[:Purpose][:item_type]
					when '1'
						purpose=""
					when '2'
					purpose="Rental"
						
					when '3'
						purpose="Sale"
				
				end
				
				
					#Properties.create(:property_id => params[:propertyid],:property_name=>params[:propertyname],:price=>params[:price],:state=>params[:state],:property_type=>params[:propertytype],:sub_property_type=>params[:subpropertytype],:bedroom=>params[:bedroom],:image=>@path1)
		connection = ActiveRecord::Base.connection();
		Properties.find_by_sql(["INSERT INTO properties_"+session[:master_user_id].to_s+"(property_name,price,state,property_type,purpose,bedroom,image,sub_property_type,contant,created_at,updated_at) VALUES (?,?,?,?,?,?,?,?,?,?,?)",params[:propertyname],params[:price],params[:state],property_type,purpose,params[:bedroom].to_i,@path1,sub_property_type,params[:contant],Time.now.strftime("%m/%d/%Y"),Time.now.strftime("%m/%d/%Y")])
		#connection.execute(INSERT INTO properties_+session[:master_user_id].to_s+(property_id,property_name,price,state,property_type,purpose,bedroom,image,sub_property_type,contant,created_at,updated_at) VALUES +(1,params[:propertyname],params[:price],params[:state],params[:propertytype],params[:purpose],params[:bedroom],@path,params[:subpropertytype],params[:contant])
			
		
			end
		end
		
		def property_edit
			
			#@t=Properties.find_by_sql(["select * from properties_"+session[:master_user_id].to_s +" where property_id = ?  ", @a])
			if params[:commit]=="Save" then
				Properties.find_by_sql(["update properties_"+session[:master_user_id].to_s+"  set property_name = ?, price = ?,state=? ,property_type = ?,purpose = ?, sub_property_type = ? ,bedroom =?,contant=? where property_id = ? ",params[:propertyname],params[:price],params[:state],params[:propertytype],params[:purpose],params[:subpropertytype],params[:bedroom],params[:contant],params[:propertyid]])
				#redirect_to :action => 'admin_property_view'
			 redirect_to :controller=>session[:master_user_name], :action => 'admin_property_view'
			else	
				@a=params[:id]
				connection = ActiveRecord::Base.connection();
				@t=connection.execute("select * from properties_" +session[:master_user_id].to_s + " where property_id ="+ @a)
			end
		end
		
		def property_delete
			connection = ActiveRecord::Base.connection();
				@t=connection.execute("DELETE FROM properties_" +session[:master_user_id].to_s+ " WHERE property_id=" +params[:id])
			#Properties.find_by_sql(["DELETE FROM properties WHERE property_id= ?",[params[:id]]])
			#redirect_to :action => 'admin_property_view'
		 redirect_to :controller=>session[:master_user_name], :action => 'admin_property_view'
		end
		
		def admin
		
			if params[:g] == "h" then 
				session[:adminflag]="false"
			end
			
			if params[:commit]=="upload"
			
			connection = ActiveRecord::Base.connection();
				password=(MasterUsers.find_by_master_user_id(session[:master_user_id])).password
			if(password==params[:currentpwd]) then 
				User.find_by_sql(["update master_users set password = ? where master_user_id = ? ",params[:newpwd],session[:master_user_id]])
				flash[:notice] = "#{'password is updated sucessfully'}"
				#redirect_to :action => 'userlogin'
			 redirect_to :controller=>session[:master_user_name], :action => 'adminhome'
			else
				flash[:notice] = "#{'current password invalid'}"
				#redirect_to :action => 'userchangepwd'
			 redirect_to :controller=>session[:master_user_name], :action => 'changepwd'
			end	
			
			end
			
			
			if params[:commit]== "login" then
				connection = ActiveRecord::Base.connection();
				member=connection.execute("select * from master_users where shop_name="+"'"+params[:shopname].to_s+"'")
				if 	member[0]==nil  then
					flash[:notice] = "#{'There is no shop with this name'}"					
								redirect_to :action => 'admin'
				else
					member=connection.execute("select * from master_users where shop_name="+"'"+params[:shopname].to_s+"'")
					member.each do |row|
						if   row["password"]==params[:password]
							if  row["validate"]=="t" then
								#session[:userid]=params[:loginid]
								#session[:userflag]="true"
								session[:mode]="edit"
								session[:masterflag]="true"
								#session[:masterflag]="true"
								session[:master_user_id]=row["master_user_id"]
								 redirect_to :controller=>row["shop_name"], :action => 'adminhome'
								#redirect_to :action => 'adminhome'
								
							else
								flash[:notice] = "#{'you need to varify your Email id before a'}"					
								#redirect_to :action => 'admin'
							 redirect_to :controller=>session[:master_user_name], :action => 'admin'
							end
						else
							flash[:notice] = "#{'Invalid Password details'}"					
							#redirect_to :action => 'admin'
							 redirect_to :controller=>session[:master_user_name], :action => 'admin'
					
					
						end
					end		
				end
		
				
			else 
			 render :layout => 'front'
			
			end
							
		
			
		end
		
		def uchangepwd
		connection = ActiveRecord::Base.connection();
				password=connection.execute("select password from users_" +session[:master_user_id].to_s+ " WHERE sub_user_id=" +params[:user_id])
			if(password[0]["password"]==params[:currentpwd]) then 
				User.find_by_sql(["update users_"+ session[:master_user_id].to_s+ " set password = ? where sub_user_id = ? ",params[:newpwd],params[:user_id]])
				flash[:notice] = "#{'password is updated sucessfully'}"
				#redirect_to :action => 'userlogin'
			 redirect_to :controller=>session[:master_user_name], :action => 'userlogin'
			else
				flash[:notice] = "#{'user id and password not match'}"
				#redirect_to :action => 'userchangepwd'
			 redirect_to :controller=>session[:master_user_name], :action => 'userchangepwd'
			end	
		end
		
		def userlogout
			session[:userid]=0
			session[:userflag]="false"
			#redirect_to :action => 'home'
			 redirect_to :controller=>session[:master_user_name], :action => 'home'
		end
		
		def logout
		session[:masterflag]="false"
		   session[:adminflag]="false"
		   session[:mode]="false"
		   
		  # redirect_to :action => 'home'
		  redirect_to :controller=>session[:master_user_name], :action => 'home'
       end
	   
		def adminlogin
			if params[:commit] == "login" then
				if   member = Adminlogin.find_by_loginid(params[:loginid]) && pwd = Adminlogin.find_by_password(params[:password])
					session[:adminflag]="true"
					#redirect_to :action => 'home'
				redirect_to :controller=>session[:master_user_name], :action => 'home'
				else
					flash[:notice] = "#{'Invalid Login and Password details'}"					
					#render "login"
				redirect_to :controller=>session[:master_user_name], :action => 'login'
				end	
			end
		end
	
		def home
			
		s="SELECT * FROM properties_" + session[:master_user_id].to_s + " ORDER BY created_at DESC"
			connection = ActiveRecord::Base.connection();
				@t=connection.execute(s)
			
			#@t=Properties.find_by_sql(s)
			
					
		end
		
		def homesearch
			if params[:name]=="Residential" then 
				if session[:userid] !=0 then 
					connection = ActiveRecord::Base.connection();
					t=connection.execute("select my_properties from users_" +session[:master_user_id].to_s + " where sub_user_id ="+ session[:userid].to_s)
					
						if @x=t[0]["my_properties"] then 
						@x.slice! ",0"
					
						end
					
					if @x != nil then			
						@a= @x+","+(params[:p_id])+",0"
					else
						@a= '0'+","+(params[:p_id])
					end
					User.find_by_sql(["UPDATE users_" + session[:master_user_id].to_s+ " SET my_properties=? WHERE sub_user_id=?",@a,session[:userid]])
					flash[:notice] = "#{'This property is added to your list sucessfully' }"
					#redirect_to :action => 'search',:name=>"addlist"
					redirect_to :controller=>session[:master_user_name], :action => 'search',:name=>"addlist"
				end
			end
			if params[:name]=="R"
			
				@t=[]
				@test=[]
				connection = ActiveRecord::Base.connection();
				t=connection.execute("select my_properties from users_" +session[:master_user_id].to_s + " where sub_user_id ="+ session[:userid].to_s)
				if @a=t[0]["myproperties"] then 
				@p=@a.split(',')
				@p.each do |i|
					if i!='0'  then 
					@test<<i
						#@t<<Properties.find_by_property_id(i)
						@t<< connection.execute("select * from properties_" +session[:master_user_id].to_s + " where property_id=" +i)
					end
				end
				end 
			end		
			if params[:name]=="delete"
				@t=[]
				@test=[]
				connection = ActiveRecord::Base.connection();
				t=connection.execute("select my_properties from users_" +session[:master_user_id].to_s + " where sub_user_id ="+ session[:userid].to_s)
				if @a=t[0]["my_properties"] then 
				@p=@a.split(',')
				@p.each do |i|
					if i!='0'  then 
					@test<<i
						#@t<<Properties.find_by_property_id(i)
						@t<< connection.execute("select * from properties_" +session[:master_user_id].to_s + " where property_id=" +i)
					end
				end
				end 
			
			end	
			#redirect_to :action => 'saved'
			 
		end
		
		def contact
			if params[:commit] == "submit" then
				Properties.find_by_sql(["INSERT INTO contactpeople_"+session[:master_user_id].to_s+"(name,email,phone,message) VALUES (?,?,?,?)",params[:name],params[:email],params[:phone],params[:message]])
				#Contactperson.create(:name =>params[:name],:email =>params[:email],:message =>params[:message],:phone=>params[:phone])
				UserMailer.contact_request(session[:c_email], params[:name],params[:email],params[:phone],params[:message]).deliver
				flash[:notice] = "#{'We accept your request,we will contact you ' }"
				
			end
		end
	
		def contaview
		connection = ActiveRecord::Base.connection();
				@t=connection.execute("select * from contactpeople_"+session[:master_user_id].to_s)
			if params[:commit] == "viewall" then
				#@t=Contactperson.all
				connection = ActiveRecord::Base.connection();
				@t=connection.execute("select * from contactpeople_"+session[:master_user_id].to_s)
			end
			if params[:name]=="deletecontact"
			connection = ActiveRecord::Base.connection();
				connection.execute("DELETE FROM contactpeople_" +session[:master_user_id].to_s+" WHERE message="+"'" +(params[:message].to_s)+ "'")
				#redirect_to :action => 'contaview'
				redirect_to :controller=>session[:master_user_name], :action => 'contaview'
			end
			
		end
		def senddetails
		connection = ActiveRecord::Base.connection();
				email=connection.execute("select email from users_" +session[:master_user_id].to_s + " where sub_user_id ="+ session[:userid].to_s)
			#email=(User.find_by_user_id(session[:userid])).email
			#name=(User.find_by_user_id(session[:userid])).name
			name=connection.execute("select name from users_" +session[:master_user_id].to_s + " where sub_user_id ="+ session[:userid].to_s)
			#@p_id=params[:p_id]
			#property=Properties.find_by_property_id(@p_id)
			property=connection.execute("select * from properties_" +session[:master_user_id].to_s + " where property_id ="+ params[:p_id].to_s)
			Properties.find_by_sql(["INSERT INTO leads_"+session[:master_user_id].to_s+"(user_id,property_id,created_at ) VALUES (?,?,?)" ,session[:userid],property[0]["property_id"],Time.now.strftime("%m/%d/%Y")])
			#UserMailer.property_details(property[0], email[0]["email"],name[0]["name"]).deliver
			flash[:notice] = "#{'Details of this Property is send to your Email Id ' }"
			redirect_to :controller=>session[:master_user_name], :action => 'search',:name=>"intrested"
			#redirect_to :action => 'search',:name=>"intrested"
		end
		
		def listing
		@click=params[:click]
			@p_id=params[:p_id]
			@img=params[:img]
			@price=params[:price]
			@bed=params[:bed]
			@name=params[:nam]
			@purpose=params[:purpose]
			@type=params[:type]
			@contant=params[:contant]
		end
		
		def about
		end
		
		def story
			#@t=Storiess.all
			connection = ActiveRecord::Base.connection();
				@t=connection.execute("select * from storiesses_" +session[:master_user_id].to_s)
			if params[:commit] == "upload" then
				name = params[:upload][:file].original_filename
				directory = "public/images/"
				@path = File.join(directory, name)
				File.open(@path, "wb") { |f| f.write(params[:upload][:file].read) }
				flash[:notice] = "File uploaded"
				@path1 = File.join("/images/", name)
			
				  Properties.find_by_sql(["INSERT INTO storiesses_"+session[:master_user_id].to_s+"( sub_user_id,name,email,phone,story,image) VALUES (?,?,?,?,?,?)",session[:userid],params[:name],params[:email],params[:phone],params[:story],@path1])
					
				 #Storiess.create(:name =>params[:name],:email =>params[:email],:story =>params[:story],:image =>@path1,:phone=>params[:phone],:user_id=>@a)
			end
		end
		
	    def storyview
			if params[:mystories]=="mystories" then
			connection = ActiveRecord::Base.connection();
				#@t=Storiess.find_by_sql(["select * from  storiesses  WHERE user_id=?",session[:userid]])
				@t=connection.execute("SELECT * FROM storiesses_"+ session[:master_user_id].to_s+" where sub_user_id ="+session[:userid].to_s )
			end
			
			
			
			if params[:name] == "viewall" then
				#@t= Storiess.all
				#s=SELECT * FROM storiesses_" + session[:master_user_id].to_s 
			connection = ActiveRecord::Base.connection();
				@t=connection.execute("SELECT * FROM storiesses_"+ session[:master_user_id].to_s )
			end
		end
       
       def storyparticular
			@u_id=params[:u_id]
			@s_id=params[:s_id]
            @a=params[:name]
			connection = ActiveRecord::Base.connection();
				@t=connection.execute("SELECT * FROM storiesses_"+ session[:master_user_id].to_s+" where story_id="+ @s_id.to_s )
					#@t=connection.execute("SELECT * FROM storiesses_"+ session[:master_user_id].to_s+" where sub_user_id ="+@s_id.to_s )
            #@t =  Storiess.find_by_sql(["select * from storiesses where id = ?  ", @a])
           
       end
		
		def adminhome
		
			
			
			 render :layout=>"adminhome"
		
			if params[:commit]=="Save" then
			
			
							connection = ActiveRecord::Base.connection();
							#@t= "select * from properties_" + session[:master_user_id].to_s+ " where sub_user_id = "+params[:loginid]
						   member=connection.execute("select * from homes where user_id ="+ session[:master_user_id].to_s)
			
							#@x = Masterhome.find_by_sql(["select * from masterhomes where user_id = ?  ", session[:master_user_id]])
			
				logo = member[0]["logo"]
				slider_img_1 = member[0]["slider_img_1"]
				slider_img_2 = member[0]["slider_img_2"]
				slider_img_3 = member[0]["slider_3"]
				c_img_1 = member[0]["c_img_1"]
				c_img_2 = member[0]["c_img_2"]
				
				
				if !params[:upload].blank?
					 if name = params[:upload][:file].original_filename  then
					
					directory = "public/images/"
					@path = File.join(directory, name)
					File.open(@path, "wb") { |f| f.write(params[:upload][:file].read) }
					flash[:notice] = "File uploaded"
					@path = File.join("/images/", name)
					logo = @path
					end
				end
				
				
				if !params[:upload1].blank?
					if name = params[:upload1][:file1].original_filename then
						directory = "public/images/"
						@path = File.join(directory, name)
						File.open(@path, "wb") { |f| f.write(params[:upload1][:file1].read) }
						flash[:notice] = "File uploaded"
						@path1 = File.join("/images/", name)
						slider_img_1 = @path1
					end
				end
			
			
				if !params[:upload2].blank?
					 if name = params[:upload2][:file2].original_filename then
				
						directory = "public/images/"
						@path = File.join(directory, name)
						File.open(@path, "wb") { |f| f.write(params[:upload2][:file2].read) }
						flash[:notice] = "File uploaded"
						@path2 = File.join("/images/", name)
						slider_img_2 = @path2
					end
				end
			
			
				if !params[:upload3].blank?
					if name = params[:upload3][:file3].original_filename  then
						directory = "public/images/"
						@path = File.join(directory, name)
						File.open(@path, "wb") { |f| f.write(params[:upload3][:file3].read) }
						flash[:notice] = "File uploaded"
						@path3 = File.join("/images/", name)
						slider_img_3 = @path3
					end
				end
				
				
				
				if !params[:upload4].blank?
					 if name = params[:upload4][:file4].original_filename  then
						directory = "public/images/"
						@path = File.join(directory, name)
						File.open(@path, "wb") { |f| f.write(params[:upload4][:file4].read) }
						flash[:notice] = "File uploaded"
						@path4 = File.join("/images/", name)
						c_img_1 = @path4
					end
				end
				
				
				if !params[:upload5].blank?
					if name = params[:upload5][:file5].original_filename then
						directory = "public/images/"
						@path = File.join(directory, name)
						File.open(@path, "wb") { |f| f.write(params[:upload5][:file5].read) }
						flash[:notice] = "File uploaded"
						@path5 = File.join("/images/", name)
						c_img_2 = @path5
					
				
					end
				end
			
				Home.find_by_sql(["update homes set c_name = ?, address = ?,phone=? ,logo = ?, slider_img_1 = ?,slider_img_2 = ?,slider_3 = ?, c_img_1 = ?, c_img_2 = ? where user_id = ? ",params[:companyname],params[:address],params[:phone],logo,slider_img_1,slider_img_2,slider_img_3,c_img_1,c_img_2,session[:master_user_id]])
				
			end		
		
		end
		
		def search
			if params[:commit] == "Submit" then
				
				s="select * from properties_" +session[:master_user_id].to_s+ " where "	
				if params[:state]== "State" then

				else
					s=s+" state= "+  "\'"+params[:state]+"\'"+" and "
				end 
				if params[:i]== "Property_ID" then

				else
					s=s+"  property_id="+ params[:i]+" and "
				end
				case params[:price][:item_type]
					when '1'
						
					when '2'
						s= s+ " price BETWEEN '100' AND '300' and
"
					when '3'
						s= s+" price BETWEEN '300' AND '600' and "
					
					when '4'
						s= s+" price BETWEEN '600' AND '900' and "
					when '5'
						s= s+" price >900 and "
						
				end
				case params[:property_type][:item_type]
					when '1'
						
					when '2'
						s= s+ " property_type= "+  "\'"+"commercial"+"\'"+"  and"
						@pt="commercial"
					when '3'
						s= s+" property_type= "+  "\'"+"industrial"+"\'"+"  and"
						@pt="industrial"
					when '4'
						s= s+" property_type= "+  "\'"+"land"+"\'"+"  and"
						@pt="Land"
					when '5'
						s= s+" property_type= "+  "\'"+"residential"+"\'"+"  and"
						@pt="Residential"
						
				end
				case params[:bed_room][:item_type]
					when '1'
						
					when '2'
						s= s+ " bedroom= 1" + " and"
					when '3'
						s= s+ " bedroom=  2" +" and"  
					
					when '4'
						s= s+" bedroom=  3"+ " and"
					when '5'
						s= s+" bedroom >=  4"+  " and"
						
				end
				s=s+"   1=1"
				@t =s
					connection = ActiveRecord::Base.connection();
					$testsearch=s
					@t=connection.execute(s)
				
				#@t=Properties.find_by_sql(s)
				s=0
				
				@t.each do |i|

					s=s+1
				end
				@s=s
				$l=@t
			end
	
			if params[:name]=="addlist"
				connection = ActiveRecord::Base.connection();
				@t=connection.execute("SELECT * FROM properties_" +session[:master_user_id].to_s + " ORDER BY updated_at ASC")
				#@t=Properties.find_by_sql("SELECT * FROM properties_" +session[:master_user_id].to_s + " ORDER BY updated_at ASC" )
				s=0
				@t.each do |i|

					s=s+1
				end
				@s=s
				@pt="Latest Properties "
				$l=@t
			end
				if params[:name]=="delete"
				connection = ActiveRecord::Base.connection();
				@t=connection.execute("SELECT * FROM properties_" +session[:master_user_id].to_s + " ORDER BY updated_at ASC")
				#@t=Properties.find_by_sql("SELECT * FROM properties_" +session[:master_user_id].to_s + " ORDER BY updated_at ASC" )
				s=0
				@t.each do |i|

					s=s+1
				end
				@s=s
				@pt="Latest Properties "
				$l=@t
			end
			if params[:name]=="search"
			connection = ActiveRecord::Base.connection();
				@t=connection.execute("SELECT * FROM properties_" +session[:master_user_id].to_s + " ORDER BY updated_at ASC")
				#@t=Properties.find_by_sql("SELECT * FROM properties_" +session[:master_user_id].to_s + " ORDER BY updated_at ASC" )
				s=0
				@t.each do |i|

					s=s+1
				end
				@s=s
				@pt="Latest Properties "
				$l=@t
			end
			
			if params[:name]=="intrested"
				connection = ActiveRecord::Base.connection();
				@t=connection.execute("SELECT * FROM properties_" +session[:master_user_id].to_s + " ORDER BY updated_at ASC")
				#@t=Properties.find_by_sql("SELECT * FROM properties_" +session[:master_user_id].to_s+ " ORDER BY updated_at ASC" )
				s=0
				@t.each do |i|

					s=s+1
				end
				@s=s
				@pt="Latest Properties "
				$l=@t
			end
			if params[:name]== "Residential" then 
			 s= "select * from properties_" + session[:master_user_id].to_s+ " where property_type = 'residential'"
       connection = ActiveRecord::Base.connection();
				@t=connection.execute(s)
				#@t=Properties.find_by_sql(s)
				s=0
				@t.each do |i|

					s=s+1
				end
				@s=s
				@pt="Residential "
				$l=@t
			end
			if params[:name]== "Industrial" then 
			 s= "select * from properties_" + session[:master_user_id].to_s+ " where property_type = 'industrial'"
				connection = ActiveRecord::Base.connection();
				@t=connection.execute(s)
				#@t=Properties.find_by_sql(s)
				s=0
				@t.each do |i|

					s=s+1
				end
				@s=s
				@pt="Industrial "
				$l=@t
			end
			if params[:name]== "Land" then 
			 s= "select * from properties_" +  session[:master_user_id].to_s+ " where property_type = 'Land'"
				connection = ActiveRecord::Base.connection();
				@t=connection.execute(s)
				#@t=Properties.find_by_sql(s)
				s=0
				@t.each do |i|

					s=s+1
				end
				@s=s
				@pt="Land "
				$l=@t
			end
			if params[:name]== "Commercial" then 
				s= "select * from properties_" + session[:master_user_id].to_s+ " where property_type = 'commercial'"
				connection = ActiveRecord::Base.connection();
				@t=connection.execute(s)
				#@t=Properties.find_by_sql(s)
				s=0
				@t.each do |i|

					s=s+1
				end
				@s=s
				@pt="Commercial "
				$l=@t
			end
			
			if params[:commit] == "goo" then
				
				@t = $l
				@array = []
				@arr = []
				if params[:sale_checkbox] == "sale" then
					@t.each do |i|
						if i["purpose"] == "sale"
							@arr << i
						
						end
					end
					@t = @arr
				end
				if params[:rental_checkbox] == "rental" then
					@t.each do |m|				
				
						if m["purpose"] == "rental"
							@arr << m
						end
					end
					@t = @arr
				end
				
				if params[:condo_checkbox] == "condo" ||  params[:appartment_checkbox] == "appartment" || params[:duplex_checkbox] == "duplex" || params[:triplex_checkbox] == "triplex"
						
					if params[:condo_checkbox] == "condo" then
						@t.each do |m|	
							
							if m["sub_property_type"] == "condo"
								@array << m
								@pt="Condo "
							end
							
						end
					end
					
					if params[:appartment_checkbox] == "appartment" then
						@t.each do |m|					
							if m["sub_property_type"] == "appartment"
								@array << m	
							end
								
						end
						
					end
					
					if params[:duplex_checkbox] == "duplex" then
						@t.each do |m|				
							if m["sub_property_type"] == "duplex"
								@array << m
							end
						end
					end
					
					if params[:triplex_checkbox] == "triplex" then
						@t.each do |m|				
							if m["sub_property_type"] == "triplex"
								@array << m
							end
							
						end
					end
					@t=@array
					
				end	
			end
		end
		
		def abc
		connection = ActiveRecord::Base.connection();
	@t=connection.execute("select max(r_req_no) from contactmail_"+session[:master_user_id].to_s);
			
		end

		
	end 
	
	
	
	
  
