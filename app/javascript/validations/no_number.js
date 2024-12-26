function validateNoNumbers(inputSelector, errorMessageText) {
  document.addEventListener('DOMContentLoaded', () => {
    const inputField = document.querySelector(inputSelector);

    if (!inputField) return; // Exit if the selector doesn't match any element

    const errorMessage = document.createElement('p');
    errorMessage.className = 'text-red-500 text-sm mt-1';
    errorMessage.style.display = 'none';
    errorMessage.textContent = errorMessageText;
    inputField.parentNode.appendChild(errorMessage);

    inputField.addEventListener('input', () => {
      if (/\d/.test(inputField.value)) {
        errorMessage.style.display = 'block';
      } else {
        errorMessage.style.display = 'none';
      }
    });
  });
}



// Invoke the function for specific fields
validateNoNumbers('input[name="student[name]"]', 'Tidak boleh ada angka dalam kolom ini.');
validateNoNumbers('input[name="student[nickname]"]', 'Tidak boleh ada angka dalam kolom ini.');
validateNoNumbers('input[name="teacher[name]"]', 'Tidak boleh ada angka dalam kolom ini.');
