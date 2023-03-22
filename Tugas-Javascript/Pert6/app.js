$('#show').click(function(){
    if ($('#show').text() == 'Show') {
        $('#image').show('slow');
        $('#image2').show('slow');
        $('#image3').show('slow');
        $('#show').text('Hide');
    } else if ($('#show').text() == 'Hide') {
        $('#image').hide('slow');
        $('#image2').hide('slow');
        $('#image3').hide('slow');
        $('#show').text('Show');
    }
})