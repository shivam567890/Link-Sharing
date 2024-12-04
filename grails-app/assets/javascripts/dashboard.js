
function showCard(cardNumber) {
  // Hide all cards
  var cards = document.querySelectorAll('.share_l.pop_up');
  cards.forEach(function(card) {
    card.style.display = 'none';
  });

  // Show the selected card
  var cardId = 'card' + cardNumber;
  var selectedCard = document.getElementById(cardId);
  selectedCard.style.display = 'block';
}

// Function to hide the card
function hideCard(cardNumber) {
  var cardId = 'card' + cardNumber;
  var selectedCard = document.getElementById(cardId);
  selectedCard.style.display = 'none';
}

// Get all cancel buttons
var cancelButtons = document.querySelectorAll('.cancelButton');

// Add click event listeners to each cancel button
cancelButtons.forEach(function(cancelButton) {
cancelButton.addEventListener('click', function() {
  // Hide the corresponding card when the cancel button is clicked
  var card = this.parentNode; // Get the parent div (card)
  card.style.display = 'none';
});
});


//     // browse data from the pc to share them using Share Document.
  document.getElementById('browseButton').addEventListener('click', function() {
  document.getElementById('fileInput').click();
});

document.getElementById('fileInput').addEventListener('change', function() {
  var fileInput = document.getElementById('fileInput');
  var fileNameDisplay = document.getElementById('fileName');

  if (fileInput.files.length > 0) {
    var fileName = fileInput.files[0].name;
    fileNameDisplay.textContent = 'Selected File: ' + fileName;
  } else {
    fileNameDisplay.textContent = '';
  }
});
