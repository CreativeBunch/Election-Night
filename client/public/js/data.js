(function() {
    'use strict';
    window.electionNight = window.electionNight || {};


    var candidateInfo = {};
    var candidateName = $('name').val();
    var avatar = $('image_url').val();
    var will = $('willpower').val();
    var char = $('charisma').val();
    var intel = $('intelligence').val();

    var candidateA;
    var candidateB;

    window.electionNight.newCandidate = function newCandidate (name, image_url,intelligence, charisma, willpower) {
        $.ajax({
            url: '/candidates',
            data: JSON.stringify({
              name: candidateName,
              image_url: avatar,
              willpower: will,
              charisma: char,
              intelligene: intel
            }),
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            }//end of headers for POST ajax call
          .done(function handleCandidate(data) {
              event.preventDefault()
              console.log("it worked!");
              console.log(data);
          })//end done click hanlder
          .fail(function handleCandidateError(xhr, errorType) {
              if (errorType > 400 || errorType < 499) {
                  console.log('Oh no! Client error. please check your data and re-submit.');
              }//end of how to handle CLIENT error for newCandidate

              if (errorType > 500 || errorType <599) {
                  console.log('Oh no! Server error! We need to make sure our server is working as it should');
              }//end of how to handle server error for newCandidate
              console.log("it worked!");
              console.log(data);
          })//end done click hanlder
          .fail(function handleCandidateError(xhr) {
              if (xhr > 400 || xhr < 499) {
                  console.log('Oh no! Client error. please check your data and re-submit.');
              }

              if (xhr > 500 || xhr <599) {
                  console.log('Oh no! Server error! We need to make sure our server is working as it should');
              }
          })//ends fail event handler
        });//end of ajax call for GET /candidates
    }//ends new candidate function

    window.electionNight.getCandidates = function getCandidates (data) {
        $.ajax({
            url: '/candidates/:id/campaigns',
            dataType: 'json',
            headers: {
                'Content-Type': 'application/json'
            }//end of header for getCandidates
        })
        .done(function handleGetCandidatesSuccess(data) {
            console.log("Call successful");
        })//end of ajax call for getCandidates
        .fail(function handleGetCandidatesError(xhr, errorType) {
            console.log("ERROR");
            if (errorType > 400 || errorType < 499) {
                console.log('Oh no! Client error. please check your data and re-submit.');
            }//end of how to handle client error for getCandidate

            if (errorType > 500 || errorType <599) {
                console.log('Oh no! Server error! We need to make sure our server is working as it should');
            }//end of how to handle server errors for getCandidate
        })//end of fail callback for getCandidate
    }//end of function for getCandidates

    window.electionNight.editCandidate = function editCandidate(candidate) {
      $.ajax({
          url: '/candidates/:id',
          method: 'PATCH',
          dataType: 'json',
          headers: {
              'Content-Type': 'application/json'
          }//end of header for editCandidate
        .done (function postEditCandidateSuccess (data) {
            console.log("Success!")
        })//end of done callback function for editCandidate
        .fail (function handleEditCandidateError(xhr, errorType){
          if (errorType > 400 || errorType < 499) {
              console.log('Oh no! Client error. please check your data and re-submit.');
          }//end of how to handle client error for editCandidate

          if (errorType > 500 || errorType <599) {
              console.log('Oh no! Server error! We need to make sure our server is working as it should');
          }//end of how to handle server errors for editCandidate
        })//end of fail callback for edit candidate
    })//end of ajax call for editCandidate
  }//end of editCandidate function

  window.electionNight.deleteCandidate = function deleteCandidate (candidate) {
      $.ajax({
          url: '/candidates/:id',
          method: 'DELETE',
          dataType: 'json',
          headers: {
              'Content-Type': 'application/json'
          }
        })
      .done (function postEditCandidateSuccess (data) {
          console.log("Success!")
      })//end of done callback function for deleteCandidate
      .fail (function handleEditCandidateError(xhr, errorType){
          if (errorType > 400 || errorType < 499) {
            console.log('Oh no! Client error. please check your data and re-submit.');
          }//end of how to handle client error for deleteCandidate

          if (errorType > 500 || errorType <599) {
            console.log('Oh no! Server error! We need to make sure our server is working as it should');
          }//end of how to handle server errors for deleteCandidate
        })//end of fail callback for deleteCandidate
      }//end of function for deleteCandidate

    window.electionNight.addCampaign = function addCampaign() {
        $.ajax({
            url: '/campaign',
            method: 'POST',
            dataType: 'json',
            headers: {
                'Content-Type': 'application/json'
            }
        })//end of ajax cal
        .done (function handleAddCampaignSuccess (data) {
            console.log("Success!")
        })//end of done callback function for addCampaign
        .fail (function handleAddCampaignError(xhr, errorType){
            if (errorType > 400 || errorType < 499) {
              console.log('Oh no! Client error. please check your data and re-submit.');
            }//end of how to handle client error for addCampaign

            if (errorType > 500 || errorType <599) {
              console.log('Oh no! Server error! We need to make sure our server is working as it should');
            }//end of how to handle server errors for addCampaign
          })//end of fail callback for addCampaign
    }//end of function for addCampaign

    window.electionNight.deleteCampaign = function deleteCampaign() {
        $.ajax({
            url: '/campaign/:id',
            method: 'DELETE',
            dataType: 'json',
            headers: {
                'Content-Type': 'application/json'
            }//end of headers for deleteCampaign
        })//end of ajax call

        .done (function deleteCampaignSuccess(data){
            console.log('Campaign deleted!');
        })
        .fail (function deleteCampaignError(xhr) {
            if (errorType > 400 || errorType < 499) {
              console.log('Oh no! Client error. please check your data and re-submit.');
            }//end of how to handle client error for deleteCandidate

            if (errorType > 500 || errorType <599) {
              console.log('Oh no! Server error! We need to make sure our server is working as it should');
            }//end of how to handle server errors for deleteCandidate
        })
    }
})();
