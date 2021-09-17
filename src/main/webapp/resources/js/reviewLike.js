console.log(" ** >> Like Module << **");
var likeService = (

    function(){
        
        function likeIt(rno, userid, callback, error){
            console.log(userid+"회원 좋아요 >>"+rno);
            $.ajax({
                type: 'post',
                url: '/board/like/'+rno+'/'+userid,
                success: function(result,status,xhr){
                    if(callback);
                },//success
                error:function(xhr,status,er){
                    if(error){
                        error(er);
                    }//if
                }//error
            })//ajax
        }//newHeart



        function unLike(rno,userid,callback,error){
            console.log(userid+"회원 좋아요 취소 >>"+rno);
            $.ajax({
                type: 'post',
                url: '/board/unlike/'+rno+'/'+userid,
                success: function(result,status,xhr){
                    if(callback){
                        callback(result);
                    }//if
                },//success
                error: function(xhr,status,er){
                    if(error){
                        error(er);
                    }//if
                }//error
            })//ajax
        }//unLike


        function likeChecking(rno, callback, error){
            console.log("ajax_get");
                // $.get("/board/get")
            $.ajax({
                type:'post',
                url:'/board/like/check/'+rno,
                success: function(result,status, xhr){
                    if(callback){
                        callback(result);
                    }
                },
                error: function(xhr,status,er){
                    if(error){
                        error(er);
                    }//if
                }//error
            })//ajax
        }//likeCehck

        return{
            likeIt: likeIt,
            unLike: unLike,
            likeChecking: likeChecking
        }
    }//function

)();//likeService