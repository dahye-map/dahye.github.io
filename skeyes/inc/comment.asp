<script type="text/javascript" src="../lib/js/comment.js"></script>
<script type="text/javascript">
<!--
  $(document).ready(function(){
	  //자료 리스트 가져오기
	  $("#df_FolderNM").val("<%= FolderNM %>");
	  $("#df_MenuCode").val("<%= MenuCode %>");
	  
	  $("#cf_FolderNM").val($("#df_FolderNM").val());
	  $("#cf_MenuCode").val($("#df_MenuCode").val());
	
	  get_comment_list(1);
  });
//-->
</script>
		<div class="comment-wrap">

                <div id="comment-write">
                    <div class="pict"><img src="../img/common/comment_pict_pc.gif" /></div>
                    <form name="comment_form" method="post" id="comment-form">
					<input type="hidden" name="FolderNM" id="cf_FolderNM" value="">
					<input type="hidden" name="MenuCode" id="cf_MenuCode" value="">
                        <div class="comment-id">
						<style type="text/css">
						
						</style>
                           <ul class="comment-ul">
								<li>
									<label class="label" ><img src="../img/common/comment_name.gif" /></label>
								   <input id="WriterName" name="WriterName" type="text" class="comment-name" value="" size="6" maxlength="10" style="width: 100px;">
								</li>
								<li>
									<label class="label"><img src="../img/common/comment_number.gif" /></label>
									<input id="emp_no" name="emp_no" type="text" class="comment-number" value="" size="6" maxlength="10" style="width: 100px;">
								</li>
								<li>
									<label class="label" ><img src="../img/common/comment_password.gif" /></label>
									<input id="Re_PW" name="Re_PW" type="password" class="comment-password" value="" size="6" maxlength="4" style="width: 100px;">
								</li>
						   </ul>
                        </div>
                        <div class="notices">*비밀번호는 댓글 삭제시 필요합니다. 숫자 4자리로 입력해 주세요.</div>
                       <div class="comment-field">
                        <textarea id="Comment" name="Comment" cols="30" rows="2" class="comment-input"></textarea>
                        <input name="submit" type="button" id="btn-comment" value="등록" onclick="insert_comment()" />                            
                       </div>
                  </form>   
                </div>

                <ul class="comment-list" id="comment-list">

                </ul>

                <div class="pagination page-bottom" id="comment_paging">

				</div>

            </div><!-- comment-wrap //-->

            <div id="popup-wrap">
                <h4>비밀번호 확인</h4>
                <p>
                    <span class="notices">댓글작성시 입력한 4자리 숫자를 입력하세요.</span>
                    <input type="password" name="input_pw" id="comment_input_pw" class="comment-password" value="" size="6" maxlength="4" style="width: 200px;">
                </p>
                <p>
                    <input name="submit" type="submit" class="btn close" value="취소" onclick="delete_cancel()" />
                    <input name="submit" type="submit" class="btn close" value="확인" onclick="delete_comment()" />
                </p>
            </div>

		<form name="data_form" id="data_form">
		<input type="hidden" name="FolderNM" id="df_FolderNM" value="">
		<input type="hidden" name="MenuCode" id="df_MenuCode" value="">
		<input type="hidden" name="page" id="df_page" value="1">
		<input type="hidden" name="list_cnt" id="df_list_cnt" value="5">
		<input type="hidden" name="page_cnt" id="df_page_cnt" value="5">
		<input type="hidden" name="IDX" id="df_IDX" value="">
		<input type="hidden" name="passwd" id="df_passwd" value="">
		</form>

