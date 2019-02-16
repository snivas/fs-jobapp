var STATUS = ["Open", "Closed"]
var INTERVIEW_STATUS = ["Scheduled", "Selected","Offered", "No Response", "Rejected"]
var BASE_URL="http://snivas.pythonanywhere.com"

$(document).ready(function() {
    var jobtable = $('#jobslist').DataTable( {
        "ordering": true,
        "info":     false,
        "searching" : false,
        "lengthChange": false,
        "ajax": {
                    "url": BASE_URL + "/jobs/",
                    "dataSrc": ""
                 },
        "columns": [
                    { "data": "company_name" },
                    { "data": "job_title" },
                    { "data": "posted_date", render: function (data, type, row) {
                            return data.split(" ")[0];
                    }
                    },
                    { "data": "status" , render: function (data, type, row) {
                            return STATUS[data];

                    }}
                   ]
    });

    var shortlistedtable = $('#candidatelist').DataTable( {
        "ordering": true,
        "info":     false,
        "searching" : false,
        "lengthChange": false,
        "ajax": {
                    "url": BASE_URL + "/jobs/0/shortlisted",
                    "dataSrc": ""
                 },
        "columns": [
                    { "data": "candidate_name" },
                    { "data": "works_at" },
                    { "data": "experience", render: function (data, type, row) {
                            return data;
                    }
                    },
                    { "data": "ctc" , render: function (data, type, row) {
                            return data;

                    }}
                   ]
    });

    var interviewstable = $('#interviewslist').DataTable( {
        "ordering": false,
        "info":     false,
        "searching" : false,
        "lengthChange": false,
        "bPaginate": false,
        "ajax": {
                    "url": BASE_URL + "/jobs/0/interviews/0",
                    "dataSrc": ""
                 },
        "columns": [
                    { "data": "interview_round" },
                    { "data": "interviewer" },
                    { "data": "updated_on" , render: function (data, type, row) {
                            return data.split(" ")[0];

                    }},
                    { "data": "status", render: function (data, type, row) {
                            return INTERVIEW_STATUS[data];
                    }
                    }
                   ]
    });


    $('#jobslist tbody').on('click', 'tr', function() {
        var data = jobtable.row( this ).data();
        shortlistedtable.ajax.url(BASE_URL + "/jobs/" + data['job_id'] + "/shortlisted").load();

        if ($(this).hasClass('selected')) {
            $(this).removeClass('selected');
        } else {
            jobtable.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });


    $('#candidatelist tbody').on('click', 'tr', function() {
        if ($(this).hasClass('selected')) {
            $(this).removeClass('selected');
        } else {
            shortlistedtable.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
        var data = shortlistedtable.row( this ).data();
        interviewstable.ajax.url(BASE_URL + "/jobs/" + data['job_id'] + "/interviews/" + data['candidate_id']).load();
    });

    $("#btnSearch").click(function(e){
           e.preventDefault();
           //resetTables();
           jobtable.ajax.url(BASE_URL + "/jobs?" + $("#frmSearch").serialize()).load();
    });

    jobtable.on( 'draw', function () {
       $('#jobslist tbody tr:eq(0)').click();
    });

    shortlistedtable.on( 'draw', function () {
       $('#candidatelist tbody tr:eq(0)').click();
    });

    function resetTables() {
        jobtable.clear().draw();
        shortlistedtable.clear().draw();
        interviewstable.clear().draw();
    }

    resetTables();

} );
