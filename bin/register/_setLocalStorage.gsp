<script>
    // Set user ID in localStorage
    localStorage.setItem('userId', ${userId});
    
    // Redirect to dashboard
    window.location.href = '${createLink(controller: "register", action: "dashboard")}?userId=${userId}';
</script>