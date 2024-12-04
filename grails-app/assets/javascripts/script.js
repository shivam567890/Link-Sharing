document.addEventListener('DOMContentLoaded', function() {
    const imageInput = document.getElementById('imageInput');
    const previewImage = document.getElementById('previewImage');

    imageInput.addEventListener('change', function(event) {
        const file = event.target.files[0];
        if (file) {
            if (file.type === 'image/png' || file.type === 'image/jpeg') {
                const reader = new FileReader();
                reader.onload = function(e) {
                    previewImage.src = e.target.result;
                    previewImage.style.display = 'block';
                };
                reader.readAsDataURL(file);
            } else {
                alert('Please select a PNG or JPEG image file.');
            }
        }
    });
});
