var STATUS = ["Open", "Closed", "Unknown"]
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
                    { "defaultContent" : ""},
                    { "data": "company_name" },
                    { "data": "job_title" },
                    { "data": "posted_date", render: function (data, type, row) {
                            return data.split(" ")[0];
                    }
                    },
                    { "data": "status" , render: function (data, type, row) {
                            return STATUS[data];

                    }}
                   ],
        "fnRowCallback" : function(nRow, aData, iDisplayIndex){
            var oSettings = this.fnSettings ();
            $("td:first", nRow).html(oSettings._iDisplayStart+iDisplayIndex +1);
            return nRow;
        },
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
                    { "defaultContent" : ""},
                    { "data": "candidate_name" },
                    { "data": "works_at" },
                    { "data": "experience", render: function (data, type, row) {
                            return data;
                    }
                    },
                    { "data": "ctc" , render: function (data, type, row) {
                            return data;

                    }}
                   ],
        "fnRowCallback" : function(nRow, aData, iDisplayIndex){
            var oSettings = this.fnSettings ();
            $("td:first", nRow).html(oSettings._iDisplayStart+iDisplayIndex +1);
            return nRow;
        }
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

        if ($(this).hasClass('selected')) {
            $(this).removeClass('selected');
        } else {
            jobtable.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
        rdata = jobtable.row( this ).data();
        if (typeof rdata !== "undefined") {
            shortlistedtable.ajax.url(BASE_URL + "/jobs/" + rdata['job_id'] + "/shortlisted").load();
        }
    });


    $('#candidatelist tbody').on('click', 'tr', function() {
        if ($(this).hasClass('selected')) {
            $(this).removeClass('selected');
        } else {
            shortlistedtable.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
        interviewstable.clear().draw();
        var data = shortlistedtable.row( this ).data();
        if (typeof data !== "undefined") {
            interviewstable.ajax.url(BASE_URL + "/jobs/" + data['job_id'] + "/interviews/" + data['candidate_id']).load();
        }
    });

    $("#btnSearch").click(function(e){
           e.preventDefault();
           resetTables();
           $("#panel").show();
           jobtable.ajax.url(BASE_URL + "/jobs?" + $("#frmSearch").serialize()).load();
    });

    jobtable.on( 'draw', function () {
       $('#jobslist tbody tr:eq(0)').click();
       $('#jobscnt').html(" ( " + jobtable.data().count() + " )");
    });

    shortlistedtable.on( 'draw', function () {
       $('#candidatelist tbody tr:eq(0)').click();
       $('#candidatecnt').html(" ( " + shortlistedtable.data().count() + " )");
    });

    function resetTables() {
        jobtable.clear().draw();
        shortlistedtable.clear().draw();
        interviewstable.clear().draw();
        $('#jobscnt').html("");
        $('#candidatecnt').html("");
    }

    resetTables();
    $("#panel").hide();

} );
