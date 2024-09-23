const modalImage = document.querySelector('.modal_image');
const modalBreak = document.querySelector('.modal_break');
const modalDelete = document.querySelector('.modal_delete');
const modalOpenImage = document.querySelector('.modal_btn_image');
const modalOpenBreak = document.querySelector('.modal_btn_break');
const modalOpenDelete = document.querySelector('.modal_btn_delete');
const modalCloseImage = document.querySelector('.close_btn_image');
const modalCloseBreak = document.querySelector('.close_btn_break');
const modalCloseDelete = document.querySelector('.close_btn_delete');

modalOpenImage.addEventListener('click',function(){
    modalImage.style.display = 'block';
});
modalCloseImage.addEventListener('click',function(){
    modalImage.style.display = 'none';
});

modalOpenBreak.addEventListener('click',function(){
    modalBreak.style.display = 'block';
});
modalCloseBreak.addEventListener('click',function(){
    modalBreak.style.display = 'none';
});

modalOpenDelete.addEventListener('click',function(){
    modalDelete.style.display = 'block';
});
modalCloseDelete.addEventListener('click',function(){
    modal.style.display = 'none';
});