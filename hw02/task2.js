// alert the current number 
function alertNum() {
  var curNum = document.getElementById("curNum").textContent;
  alert("current number: " + curNum);
}

// increse the current number by 1
function increseNum() {
  var curNumTag = document.getElementById("curNum");
  var curNumString = curNumTag.textContent;
  var newNum = parseInt(curNumString,10) + 1;
  curNumTag.innerHTML = newNum;
}

// append number to the bottom of page
function appendNum() {
  var para = document.createElement("p");
  var curNum = document.getElementById("curNum").textContent;
  var text = document.createTextNode(curNum);
  para.appendChild(text);
  document.body.appendChild(para);
}
