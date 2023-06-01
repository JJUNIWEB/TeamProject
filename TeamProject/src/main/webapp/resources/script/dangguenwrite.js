/*

// 최대 업로드 가능 수
const MAX_UPLOAD_IMG = 5;
// 이미지 파일
var file;
// 최대 용량 mb
var MaxSize=0.001;

$(function () {
    $(document).on("click", '#postButton', function (e) {
        //input의 파일. 지금은 파일 하나라 files[0] 다수 업로드일땐 array만들어서 넣어야함. uploadImage.jsp 참조
        file = e.target.files[0];
        //사이즈 체크 용량은 js 최상단에서 설정
        if (!checkFileSize(file, MaxSize)) {
            document.getElementById("imageinput").value = null;
            return;
        }

        //확장자 검사도?
        //-------------------------------------------
        //업로드
        console.log("uploadList" + file);
        //업로드용 폼 객체
        let formData = new FormData();
        //폼에 담기
        //controller에서 지정해둔 이름대로
        formData.append("images", file);
        formData.append("category", "dogPhoto");
        $.ajax({
            type: 'post',
            enctype: "multipart/form-data",
            url: contextPath + '/dangofficetest/upload',
            data: formData,
            processData: false,
            contentType: false,
            success: function (data) {
                //이미지 주소 출력됨
                alert(data)
            },
            error: function (e) {
                alert("error:" + e);
            }
        });//ajax
    });//change
});

*/

var list = document.getElementById('preview-list')
list.innerHTML = "";

function previewImage(input) {
    for (var i = 0 ; i < input.files.length ; i++) {
        var reader = new FileReader();
        var image = document.createElement('img');
        
        image.style.width = 'auto';
        image.style.height = '100px';
        image.style.marginRight = '10px';
        
        reader.onload = (function (img) {
        	return function (e) {
            	img.src = e.target.result;
            };
        })(image);
        
        reader.readAsDataURL(input.files[i]);
          
        list.appendChild(image);
    }
}
