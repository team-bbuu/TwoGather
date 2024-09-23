function loadFile(input) {
  let file = input.files[0]; // 선택 파일 가져오기

  let newImg = document.createElement("img"); // 새 이미지 태그 생성

  // 이미지 source 가져오기
  newImg.src = URL.createObjectURL(file);
  // newImg.style.width = "100%";
  // newImg.style.height = "100%";
  // newImg.style.objectFit = "cover";

  // 이미지를 image-show div 에 추가
  let container = document.getElementById("image-show");
  container.appendChild(newImg);
}