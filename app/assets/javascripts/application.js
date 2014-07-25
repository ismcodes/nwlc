// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
$(document).ready(function () {
    addStudentClick();


    var resp;
    var students = [];
    var sessions = [];
    var tutors = [];
    setTimeout(function () {
            for(var i = 0; i<$('.students').children().length;i++){
            students.push($('.students')[i].innerHTML.split('-').pop().split('<')[0].slice(0,-1))
            }
            for(var i = 0; i<$('.sessions').children().length;i++){
            sessions.push($('.sessions')[i].innerHTML.split('-').pop().split('<')[0].slice(0,-1))
            }
            for(var i = 0; i<$('.tutors').children().length;i++){
            tutors.push($('.tutors')[i].innerHTML.split('-').pop().split('<')[0].slice(0,-1))
            }
    }, 2000);
    setTimeout(function () {
        setInterval(function () {
            checkStuff();
        }, 5000);

    }, 3000);

    function checkStuff() {
var studentlist,sessionlist,tutorlist;
//$.ajax({url:'/amisignedout',type:'post',data:{email:$('strong').eq(1).text()}})
        $.ajax({
                url: '/getstudents',
                type: 'post',
                dataType: 'html',
                error: function (e) {
                    
                }
            }).done(function (response) {
                resp = response;
            });
        if(resp!=null){

            resp = resp.split(',');
        studentlist = resp[0].split('|');
        sessionlist = resp[1].split('|');
        tutorlist = resp[2].split('|');
        studentlist.pop();
        sessionlist.pop();
        tutorlist.pop();

        for (var i = 0; i < studentlist.length; i++) {
            var inlist = false;
            for (var j = 0; j < students.length; j++) {
                
                if (students[j] == studentlist[i]){
                    inlist = true;
                    break;
                }
            }
             if(!inlist){
              
            //student is not on the page, retrieve via ajax and append it.
            students.push(studentlist[i]);
           
            $.ajax({
            type:'post',
            url:'/getstudent',
            data:{
            email:studentlist[i]
            },
            dataType:'html'

            }).done(function(response){


$('.students').append(response);
addStudentClick();
})
			}

        }
}
    }
function addStudentClick(){
$('.student').on('click', function () {
    console.log('gonna do some ajaxxxxxxx');
    var h = $(this).find('h6');
    var cl = h.text().substring(0, h.text().indexOf(':'));
    var topic = h.text().substring(h.text().indexOf(':') + 2, h.text().length);
    console.log(h+''+cl+''+topic);
    $.ajax({
        type: 'post',
        url: 'form',
        dataType: 'html',
        data: {
            student_id: escape(h.parent().find('p').text()),
            class_name: escape(cl),
            topic: escape(topic)
        },
        error:function(err){console.log('error on student click uh oh');console.log(err)}
    }).done(function (response) {
        $('body').empty().append(unescape(response));
    });


});


}
$(window).bind('beforeunload', function (event) {
    if (event.clientX > 95) {
        console.log(clientX);

        $.ajax({
            url: "signout"
        });
    }
});

});
