<%@page pageEncoding="UTF-8" isELIgnored="false" %>
<script>
    $(function () {
        $("#list").jqGrid({
            url : '${pageContext.request.contextPath}/banner/findAll',
            datatype : "json",
            colNames : [ '编号', '名称', '封面', '描述', '状态','上传日期'],
            colModel : [
                {name : 'id',hidden:true,editable:false,align:"center"},
                {name : 'name',editable:true,align:"center"},
                {name : 'cover',editable:true,edittype:"file",align:"center",formatter:function (value,option,rows) {
                        return "<img style='width:100px;height:60px;' src='${pageContext.request.contextPath}/back/img/banner/"+rows.cover+"'>";
                    }},
                {name : 'description',editable:true,align:"center"},
                {name : 'status',editable:true,align:"center",edittype:"select",editoptions:{value:"正常:正常;冻结:冻结"}},
                {name : 'createDate',align:"center"}
            ],
            height:400,
            autowidth:true,
            styleUI:"Bootstrap",
            rowNum : 5,
            rowList : [ 5,10,15 ],
            pager : '#pager',
            sortname : 'id',
            viewrecords : true,
            caption : "轮播图列表",
            editurl : "${pageContext.request.contextPath}/banner/edit"
        }).navGrid("#pager", {edit : true,add : true,del : true,search:false},{
            //控制修改
            closeAfterEdit:true,
            beforeShowForm:function (fmt) {
                fmt.find("#cover").attr("disabled",true);
            }
        },{
            //控制添加
            closeAfterAdd:true,
            afterSubmit:function (data) {
                console.log(data);
                var status = data.responseJSON.status;
                var id = data.responseJSON.message;
                if(status){
                    $.ajaxFileUpload({
                        url:"${pageContext.request.contextPath}/banner/upload",
                        type:"post",
                        fileElementId:"cover",
                        data:{id:id},
                        success:function (response) {
                            //自动刷新jqgrid表格
                            $("#list").trigger("reloadGrid");
                        }
                    });
                }
                return "123";
            }
        });
    })
</script>
<div class="page-header" >
    <h3 style="margin-top:-34px">展示所有专辑</h3>
</div>


<%--创建表格--%>
<table id="list" ></table>

<%--分页--%>
<div id="pager" style="height: 40px;" ></div>