class SessionsController < ApplicationController
   skip_before_action :verify_authenticity_token
   #uhhh what does this do again?
def create
  user = User.from_omniauth(env["omniauth.auth"])
  session[:user_id] = user.id
  me=User.find(user.id)
  me.loggedin=true
  me.tutoring=false
  me.request=Request.new(class_name:"3365f80a5cccb3e76443df3b736b26e8")
  me.save
  render erb: :'sessions#create'
end
def about
render erb: :'sessions#about'
end
def ready
  User.find(session[:user_id]).request=Request.new(class_name: params[:class_selection],topic: params[:topic_selection])
  redirect_to '/'
end

def tutorsetup
  render erb: :'sessions#tutorsetup'
end

def updateabils
  ["Algebra 1 Regular","Algebra 1 Honors", "Algebra 1 Advanced", "Geometry Regular", "Geometry Advanced", "Geometry Honors", "Algebra 2 Regular", "Algebra 2 Advanced", "Algebra 2 Honors"].each do |klass|
    User.find(session[:user_id]).tutorabilities.where("class_name=?",klass).first.update_attribute(:ability,params[klass.to_sym])
  end
  User.find(session[:user_id]).update_attribute(:tutoring,true)
  redirect_to '/'
end

def getsession

end

def getstudent
  s=User.where("email=?",params[:email]).first
  if s.tutoring
render json: "<div class='tutor'>
  <p style='display:none'>#{s.id}</p>
<img class='headshot' style='border-radius: 100%' src=#{s.image}>
 #{s.name}-#{s.email}
</div>"
else
render json: "<div class='student'>
  <p style='display:none'>#{s.id}</p>
<img class='headshot' style='border-radius: 100%' src=#{s.image}>
<h6>#{s.request.class_name}::#{s.request.topic}</h6> #{s.name}-#{s.email}
</div>"
end
end
def getstudents
  str=""
User.where("loggedin=?",true).where("tutoring=?",false).each do |t|
 
str<<"#{t.email}|" if t.request.class_name !="3365f80a5cccb3e76443df3b736b26e8" && Tutoringsession.where("finished=?",false).where("user_id=?",t.id).length==0
end
str<<","
Tutoringsession.where("finished=?",false).each do |t|
str<<"#{t.id}|"
end
str<<","
User.where("loggedin=?",true).where("tutoring=?",true).each do |t|
  str<<"#{t.email}|" if Tutoringsession.where("finished=?",false).where("tutor_id=?",t.id).length==0
end

    render json: str
 # respond_to do |format|
 #     format.json { head :ok }
 #  end
end
def form  
  if User.find(session[:user_id]).tutoring
  ses =Tutoringsession.create(user_id:params[:student_id],tutor_id:session[:user_id],classname:params[:class_name],topic:params[:topic],finished:false)
  render erb: :'sessions#form', layout: false, locals: {extras:  {tutoringsessionid:ses.id} }
end
end

def complete
  if params[:adminusername]=="nwlitc"&&params[:adminpassword]=="2014"
    Tutoringsession.find(params[:tutoringsessionid]).update_attributes(materials:params[:materials],discussion:params[:discussion],followup:params[:followup],finished:true)
    emails=[User.find(params[:student_id]).email,params[:teacheremail]]
  report="Lit Center report for #{User.find(params[:student_id]).name}:<br><br>
<b>Materials:</b><br>
#{params[:materials]}<br>
<b>Session:</b><br>
#{params[:discussion]}<br>
<b>Follow up:</b><br>
#{params[:followup]}<br><br>
<br>
Come back soon!
<br>
#{User.find(session[:user_id]).name}
<br><br>
<em>2tor 2.0 was made by <a href='http://isaacmoldofsky.com'>Isaac Moldofsky</a>.</em>
  "
mail = Mail.deliver do
  to emails
  from 'Tutor 2.0 <hi@isaacmoldofsky.com>'
  subject 'Literacy Center report'
  html_part do
    content_type 'text/html; charset=UTF-8'
    body report
  end
end
User.find(params[:student_id]).update_attribute(:loggedin,false)
    destroy
  end
end
def checksignout
unless User.where("email=?",params[:email]).first.loggedin
  destroy
end
end

def destroy
  Tutoringsession.destroy_all(finished:false,tutor_id:session[:user_id])
  me=User.find(session[:user_id])
  me.loggedin=false
  me.tutoring=false
  me.save
  session[:user_id] = nil
  redirect_to '/about'
end

end