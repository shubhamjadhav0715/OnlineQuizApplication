// ===================================
// Online Quiz Application - Custom JavaScript
// ===================================

$(document).ready(function () {
    // Initialize tooltips
    $('[data-toggle="tooltip"]').tooltip();

    // Initialize popovers
    $('[data-toggle="popover"]').popover();

    // Smooth scroll for anchor links
    $('a[href^="#"]').on('click', function (e) {
        e.preventDefault();
        var target = this.hash;
        var $target = $(target);

        if ($target.length) {
            $('html, body').animate({
                'scrollTop': $target.offset().top - 70
            }, 500);
        }
    });

    // Auto-hide alerts after 5 seconds
    setTimeout(function () {
        $('.alert').fadeOut('slow');
    }, 5000);

    // Confirm delete actions
    $('.btn-delete').on('click', function (e) {
        if (!confirm('Are you sure you want to delete this item?')) {
            e.preventDefault();
            return false;
        }
    });

    // Form validation enhancement
    $('form').on('submit', function () {
        var isValid = true;
        
        // Check required fields
        $(this).find('[required]').each(function () {
            if ($(this).val() === '') {
                isValid = false;
                $(this).addClass('is-invalid');
            } else {
                $(this).removeClass('is-invalid');
            }
        });

        return isValid;
    });

    // Remove validation error on input
    $('input, textarea, select').on('input change', function () {
        $(this).removeClass('is-invalid');
    });

    // Quiz timer (if needed)
    if ($('#quizTimer').length) {
        startQuizTimer();
    }

    // Highlight active navigation
    highlightActiveNav();

    // Add fade-in animation to cards
    $('.card').addClass('fade-in');

    // Password strength indicator
    $('#txtPassword').on('input', function () {
        checkPasswordStrength($(this).val());
    });

    // Confirm password validation
    $('#txtConfirmPassword').on('input', function () {
        validateConfirmPassword();
    });
});

// Quiz Timer Function
function startQuizTimer() {
    var duration = parseInt($('#quizTimer').data('duration')) || 600; // Default 10 minutes
    var timer = duration;
    var minutes, seconds;

    var interval = setInterval(function () {
        minutes = parseInt(timer / 60, 10);
        seconds = parseInt(timer % 60, 10);

        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;

        $('#quizTimer').text(minutes + ":" + seconds);

        if (--timer < 0) {
            clearInterval(interval);
            alert('Time is up! Submitting quiz...');
            $('#form1').submit();
        }

        // Warning at 1 minute
        if (timer === 60) {
            $('#quizTimer').addClass('text-danger');
            alert('Only 1 minute remaining!');
        }
    }, 1000);
}

// Highlight Active Navigation
function highlightActiveNav() {
    var currentPath = window.location.pathname;
    $('.nav-link').each(function () {
        var href = $(this).attr('href');
        if (href && currentPath.indexOf(href) !== -1) {
            $(this).addClass('active');
        }
    });
}

// Password Strength Checker
function checkPasswordStrength(password) {
    var strength = 0;
    var strengthText = '';
    var strengthClass = '';

    if (password.length >= 8) strength++;
    if (password.match(/[a-z]+/)) strength++;
    if (password.match(/[A-Z]+/)) strength++;
    if (password.match(/[0-9]+/)) strength++;
    if (password.match(/[$@#&!]+/)) strength++;

    switch (strength) {
        case 0:
        case 1:
            strengthText = 'Weak';
            strengthClass = 'text-danger';
            break;
        case 2:
        case 3:
            strengthText = 'Medium';
            strengthClass = 'text-warning';
            break;
        case 4:
        case 5:
            strengthText = 'Strong';
            strengthClass = 'text-success';
            break;
    }

    $('#passwordStrength').html('<small class="' + strengthClass + '">Password Strength: ' + strengthText + '</small>');
}

// Validate Confirm Password
function validateConfirmPassword() {
    var password = $('#txtPassword').val();
    var confirmPassword = $('#txtConfirmPassword').val();

    if (password !== confirmPassword) {
        $('#txtConfirmPassword').addClass('is-invalid');
        $('#confirmPasswordError').text('Passwords do not match');
    } else {
        $('#txtConfirmPassword').removeClass('is-invalid');
        $('#confirmPasswordError').text('');
    }
}

// Show loading spinner
function showLoading() {
    $('body').append('<div class="loading-overlay"><div class="spinner-border text-primary" role="status"><span class="sr-only">Loading...</span></div></div>');
}

// Hide loading spinner
function hideLoading() {
    $('.loading-overlay').remove();
}

// Format date
function formatDate(dateString) {
    var date = new Date(dateString);
    var options = { year: 'numeric', month: 'long', day: 'numeric', hour: '2-digit', minute: '2-digit' };
    return date.toLocaleDateString('en-US', options);
}

// Copy to clipboard
function copyToClipboard(text) {
    var tempInput = $('<input>');
    $('body').append(tempInput);
    tempInput.val(text).select();
    document.execCommand('copy');
    tempInput.remove();
    
    // Show success message
    showToast('Copied to clipboard!', 'success');
}

// Show toast notification
function showToast(message, type) {
    type = type || 'info';
    var alertClass = 'alert-' + type;
    
    var toast = $('<div class="alert ' + alertClass + ' alert-dismissible fade show position-fixed" style="top: 20px; right: 20px; z-index: 9999;" role="alert">' +
        message +
        '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
        '<span aria-hidden="true">&times;</span>' +
        '</button>' +
        '</div>');
    
    $('body').append(toast);
    
    setTimeout(function () {
        toast.fadeOut('slow', function () {
            $(this).remove();
        });
    }, 3000);
}

// Print page
function printPage() {
    window.print();
}

// Export table to CSV
function exportTableToCSV(tableId, filename) {
    var csv = [];
    var rows = document.querySelectorAll('#' + tableId + ' tr');

    for (var i = 0; i < rows.length; i++) {
        var row = [], cols = rows[i].querySelectorAll('td, th');

        for (var j = 0; j < cols.length; j++) {
            row.push(cols[j].innerText);
        }

        csv.push(row.join(','));
    }

    downloadCSV(csv.join('\n'), filename);
}

// Download CSV
function downloadCSV(csv, filename) {
    var csvFile;
    var downloadLink;

    csvFile = new Blob([csv], { type: 'text/csv' });
    downloadLink = document.createElement('a');
    downloadLink.download = filename;
    downloadLink.href = window.URL.createObjectURL(csvFile);
    downloadLink.style.display = 'none';
    document.body.appendChild(downloadLink);
    downloadLink.click();
    document.body.removeChild(downloadLink);
}

// Scroll to top
function scrollToTop() {
    $('html, body').animate({ scrollTop: 0 }, 'slow');
}

// Add scroll to top button
$(window).scroll(function () {
    if ($(this).scrollTop() > 100) {
        $('#scrollTopBtn').fadeIn();
    } else {
        $('#scrollTopBtn').fadeOut();
    }
});

// Initialize scroll to top button
$('body').append('<button id="scrollTopBtn" class="btn btn-primary" style="display:none; position:fixed; bottom:20px; right:20px; z-index:999;" onclick="scrollToTop()"><i class="fas fa-arrow-up"></i></button>');
