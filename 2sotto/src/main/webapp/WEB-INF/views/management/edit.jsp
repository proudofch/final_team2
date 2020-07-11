<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>

	<title>반려동물 정보 수정</title>
	
	<%@ include file="/WEB-INF/include/import.jsp"%>
	<style>
		
		.custom-select {
			width: 200px;
		}
		
		input[type=text] {
			width: 200px;
		}
		
	</style>
</head>
<body>
	<%@ include file="/WEB-INF/include/headerAndNavi.jsp"%>
	<div class="side_overlay">
	<div class="container">
	
		<h3>반려동물 정보 수정하기</h3>
		
		<form action="edit.bit" method="post" enctype="multipart/form-data">
			
			<c:set value="${petInfo}" var="pet"/>
			<input type="hidden" name="petindex" value="${pet.petindex}">
			
			<div class="form-group bmd-form-group">
				<label for="petname" class="bmd-label-floating">이름</label>
				<input type="text" class="form-control" id="petname" name="petname" value="${pet.petname}">
			</div>
			
			<div class="form-group">
				<label for="mcategory">종류</label>
				<select class="custom-select" id="mcategory" name="mcategory"> <!-- ex) ?mcategory=dog -->
				</select>
			</div>
			
			<div class="form-group">
				<label for="scategory">종 선택하기</label>
				<select class="custom-select" id="scategory" name="scategory">
				</select>
			</div>
			
			<div class="form-check">
				<label for="sex">성별</label>
				<br>
				<label class="form-check-label">
					<input class="form-check-input" type="radio" name="sex" id="sex_female" value="female">
						암컷
					<span class="circle">
						<span class="check"></span>
					</span>
				</label>
				<label class="form-check-label">
					<input class="form-check-input" type="radio" name="sex" id="sex_male" value="male">
						수컷
					<span class="circle">
						<span class="check"></span>
					</span>
				</label>
			</div>
			
			<div class="form-group bmd-form-group">
				<label for="weight" class="bmd-label-floating">몸무게</label>
				<input type="text" class="form-control" id="weight" name="weight" value="${pet.weight}"> kg
			</div>
			
			<br>
			
			<div class="form-group">
				<label for="age">나이</label>
				<select class="custom-select" id="age_year" name="age_year">
				</select>
				년
				<select class="custom-select" id="age_month" name="age_month">
				</select>
				개월
			</div>
			
			<div class="form-check">
				<label for="hlength">털 길이</label>
				<br>
				<label class="form-check-label">
					<input class="form-check-input" type="radio" name="hlength" id="hlength_short" value="short">
						짧음
					<span class="circle">
						<span class="check"></span>
					</span>
				</label>
				<label class="form-check-label">
					<input class="form-check-input" type="radio" name="hlength" id="hlength_medium" value="medium">
						중간
					<span class="circle">
						<span class="check"></span>
					</span>
				</label>
				<label class="form-check-label">
					<input class="form-check-input" type="radio" name="hlength" id="hlength_long" value="long">
						김
					<span class="circle">
						<span class="check"></span>
					</span>
				</label>
			</div>
			
			<div class="form-check">
				<label for="size">크기</label>
				<br>
				<label class="form-check-label">
					<input class="form-check-input" type="radio" name="size" id="size_small" value="small">
						소형
					<span class="circle">
						<span class="check"></span>
					</span>
				</label>
				<label class="form-check-label">
					<input class="form-check-input" type="radio" name="size" id="size_medium" value="medium">
						중형
					<span class="circle">
						<span class="check"></span>
					</span>
				</label>
				<label class="form-check-label">
					<input class="form-check-input" type="radio" name="size" id="size_big" value="big">
						대형
					<span class="circle">
						<span class="check"></span>
					</span>
				</label>
			</div>
			
			<div class="form-check">
				<label for="nstate">중성화 여부</label>
				<br>
				<label class="form-check-label">
					<input class="form-check-input" type="radio" name="nstate" id="nstate_y" value="y">
						Y
					<span class="circle">
						<span class="check"></span>
					</span>
				</label>
				<label class="form-check-label">
					<input class="form-check-input" type="radio" name="nstate" id="nstate_n" value="n">
						N
					<span class="circle">
						<span class="check"></span>
					</span>
				</label>
			</div>
			
			<div class="form-group bmd-form-group">
				<label for="memo" class="bmd-label-floating">특이사항</label>
				<input type="text" class="form-control" id="memo" name="memo" value="${pet.memo}">
			</div>
			
			<br>
		<!-- <input type="file" id="petimg" name="petimg"> -->
										
			<button type="submit" class="btn btn-primary">수정하기</button>
			<button type="reset" class="btn btn-primary" onclick="location.href='#'">취소</button>

		</form>
	</div>
	</div>
	
	<%@ include file="/WEB-INF/include/footer.jsp"%>
</body>
<script>

	$(function() {
		
		makeAgeYear();
		makeAgeMonth();
		getMainCategory();
		firstSelection();
		makeSubCategory();
		radioCheck();

	});

	function firstSelection() {

		$('#mcategory option').each(function() {

			console.log("this text: "+$(this).text());
			if( $(this).text() == "${pet.mcaname}" ) {
					$(this).attr("selected", "selected");
				}
			});

			$('#scategory option').each(function() {
			if( $(this).val() == "${pet.scategory}" ) {
					$(this).attr("selected", "selected");
				}
		});
	}

	function getMainCategory() {

		$.ajax({
			type: "get",
			url: "getMainCategory.bit",
			success: function(data) {
				var option = "";
				$.each(data, function(index, element) {
					if( "${pet.mcaname}" == element.mcaname ) {
						option += "<option value='" + "${pet.mcategory}" + "' selected>" + "${pet.mcaname}" + "</option>";
					} else {
						option += "<option value='" + element.mcategory + "'>" + element.mcaname + "</option>";
					}
				});
				$('#mcategory').append(option);
			}
		});

	}

	function getSubCategory(element) {

		$.ajax({
			type: "get",
			url: "getSubCategory_" + element + ".bit",
			success: function(data) {
				var option = "";
				$.each(data, function(index, element) {
					if( "${pet.scaname}" == element.scaname ) {
						option += "<option value='" + "${pet.scategory}" + "' selected>" + "${pet.scaname}" + "</option>";
					} else {
						option += "<option value='" + element.scategory + "'>" + element.scaname + "</option>";
					}
				});
				$('#scategory').empty().append(option);
			}
		});

	}

	function makeSubCategory() {
		$('#mcategory').change(function() {
			if($('#mcategory').val() == '1') { // 1=개
				getSubCategory('dog');
			} else { // 2=고양이
				getSubCategory('cat');
			}
		});
	}
	
	var petAge = "${pet.age}";
	
	function makeAgeYear() {

		var petYear = petAge/12;
		var year = "";

		for(var i=0; i<=30; i++) {
			if(petYear == i) {
				year += "<option value='" + i + "' selected>" + i + "</option>";
			} else {
				year += "<option value='" + i + "'>" + i + "</option>";
			}
		}
		$('#age_year').empty().append(year);
		
	}

	function makeAgeMonth() {

		var petMonth = petAge%12;
		var month = "";
		for(var i=0; i<12; i++) {
			if(petMonth == i) {
				month += "<option value='" + i + "' selected>" + i + "</option>";
			} else {
				month += "<option value='" + i + "'>" + i + "</option>";
			}
		}
		$('#age_month').empty().append(month);
	}

	function radioCheck() {

		// 털길이
		if("${pet.hlength}" == 'short') {
			$('#hlength_short').attr("checked", "checked");
		} else if ("${pet.hlength}" == 'medium') {
			$('#hlength_medium').attr("checked", "checked");
		} else {
			$('#hlength_long').attr("checked", "checked");
		}

		// 크기
		if("${pet.size}" == 'small') {
			$('#size_small').attr("checked", "checked");
		} else if ("${pet.size}" == 'medium') {
			$('#size_medium').attr("checked", "checked");
		} else {
			$('#size_big').attr("checked", "checked");
		}

		//중성화 여부
		if("${pet.nstate}" == 'y') {
			$('#nstate_y').attr("checked", "checked");
		} else {
			$('#nstate_n').attr("checked", "checked");
		}

		//성별
		if("${pet.sex}" == 'female') {
			$('#sex_female').attr("checked", "checked");
		} else {
			$('#sex_male').attr("checked", "checked");
		}

	}
		
</script>
</html>