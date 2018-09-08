
window.addEventListener('load', (e) => {
  document.getElementsByClassName('js-date-selector')
      .addEventListener('input', changeDateValue, false);
});

function changeDateValue(e) {
  const targetElement = e.target;
  if (targetElement.id.indexOf('3') > 0) return;
  const daysPerMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  const elements = document.getElementsByClassName('js-date-selector');
  const values = [
    parseInt(elements[0].value), parseInt(elements[1].value),
    parseInt(elements[2].value)
  ];
  if (values[0] % 4 === 0 && values[0] % 100 > 0) daysPerMonth[1] == 29;
  
  
}