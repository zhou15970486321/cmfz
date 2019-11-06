<%@page pageEncoding="UTF-8" isELIgnored="false" %>
<script>
    $(function () {
        $("#list").jqGrid({
            url : '${pageContext.request.contextPath}/article/findAll',
            datatype : "json",
            colNames : [ '编号', '标题', '作者', '简介','内容','创建时间','操作'],
            colModel : [
                {name : 'id',hidden:true,editable:false,align:"center"},
                {name : 'title',editable:true,align:"center"},
                {name : 'author',editable:true,align:"center"},
                {name : 'brief',editable:true,align:"center"},
                {name : 'content',editable:true,align:"center"},
                {name : 'createDate',align:"center"},
                {name : 'operation',editable:true,align:"center",formatter:function (value,option,rows) {
                        return "<a class='btn btn-primary' data-toggle='modal' data-target='#myModal' onclick=\"openModle('edit','"+rows.id+"')\">修改</a>"+"      <a class='btn btn-danger'  href=''>删除</a>";
                    }}
            ],
            height:400,
            autowidth:true,
            styleUI:"Bootstrap",
            rowNum : 5,
            rowList : [ 5,10,15 ],
            pager : '#pager',
            sortname : 'id',
            viewrecords : true,
            caption : "所有文章展示",
        }).navGrid("#pager", {edit : false,add : false,del : false,search:false});

    })
    function openModle(oper,id) {
        if ("add"==oper){
            $("#article_id").val("");
            $("#title").val("");
            $("#author").val("");
            $("#brief").val("");
            KindEditor.html("#content","")
        }
        if ("edit"==oper){
            var article = $("#list").jqGrid("getRowData",id);
            console.log(article);
            $("#article_id").val(article.id);
            $("#title").val(article.title);
            $("#author").val(article.author);
            $("#brief").val(article.brief);
            KindEditor.html("#content",article.content)
        }
    }
    function save(){
        var id = $("#article_id").val();
        var url = "";
        if (id){
            url="${pageContext.request.contextPath}/article/edit";
        }else{
            url="${pageContext.request.contextPath}/article/add"
        }
        $.ajax({
            url: url,
            type: "post",
            datatype: "json",
            data:$("#form-horizontal").serialize(),
            success:function () {
                
            }
            
        })
    }

    KindEditor.create('#content',{
        width:'490px',
        //点击图片空间按钮时发送的请求
        fileManagerJson:"${pageContext.request.contextPath}/article/browse",
        //展示图片空间按钮
        allowFileManager:true,
        //上传图片所对应的方法
        uploadJson:"${pageContext.request.contextPath}/article/upload",
        //上传图片是图片的形参名称
        filePostName:"articleImg",
        afterBlur:function () {
            this.sync();
        }
    });


</script>
<ul class="nav nav-tabs">
    <li role="presentation" class="active"><a href="#">所有文章</a></li>
    <li role="presentation"><a href="#" data-toggle='modal' data-target='#myModal' onclick="openModle('add','')" >添加文章</a></li>
</ul>
<table id="list"></table>
<div id="pager" style="height: 40px"></div>
<%-- 模态框--%>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 683px" >
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">文章操作</h4>
            </div>
            <form class="form-horizontal" id="form-horizontal">
                <input type="hidden" name="id" id="article_id">
                <div class="form-group">
                    <label for="title" class="col-sm-2 control-label">文章标题</label>
                    <div class="col-sm-10">
                        <input type="text" name="title" class="form-control" id="title" placeholder="请输入文章标题">
                    </div>
                </div>
                <div class="form-group">
                    <label for="author" class="col-sm-2 control-label">文章作者</label>
                    <div class="col-sm-10">
                        <input type="text" name="author" class="form-control" id="author" placeholder="请输入文章作者">
                    </div>
                </div>
                <div class="form-group">
                    <label for="brief" class="col-sm-2 control-label">文章简介</label>
                    <div class="col-sm-10">
                        <input type="text" name="brief" class="form-control" id="brief" placeholder="请输入文章简介">
                    </div>
                </div>
                <textarea id="content" name="content" style="width:700px;height:300px;"></textarea>

            </form>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="save()">提交</button>
            </div>
        </div>
    </div>
</div>
