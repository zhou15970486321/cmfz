<%@page isELIgnored="false" pageEncoding="UTF-8" %>
<script>
   $(function(){
        jQuery("#list").jqGrid(
            {
                autowidth:true,
                styleUI:"Bootstrap",
                url : '${pageContext.request.contextPath}/star/findAll',
                datatype : "json",
                height :400,
                colNames : [ 'Id', '名字', '照片', '性别', '生日',],
                colModel : [
                    {name : 'id',hidden:true,editable:true,align:"center"},
                    {name : 'name',editable:true,align:"center"},
                    {name : 'photo',editable:true,align:"center",edittype:"file",formatter:function (value,option,rows) {
                            return "<img style='width:100px;height:60px;' src='${pageContext.request.contextPath}/back/img/star/"+rows.photo+"'>";
                        }},
                    {name : 'sex',editable:true,align:"center",edittype:"select",editoptions:{value:"男:男;女:女"}},
                    {name : 'bir',editable:true,align:"center",edittype:"date"}
                ],
                rowNum : 5,
                rowList : [ 5, 10, 15 ],
                pager : '#pager',
                viewrecords : true,
                subGrid : true,
                caption : "明星列表",
                editurl : "${pageContext.request.contextPath}/star/edit",
                subGridRowExpanded : function(subgrid_id, id) {
                    var subgrid_table_id, pager_id;
                    subgrid_table_id = subgrid_id + "_t";
                    pager_id = "p_" + subgrid_table_id;
                    $("#" + subgrid_id).html(
                        "<table id='" + subgrid_table_id
                        + "' class='scroll'></table><div id='"
                        + pager_id + "' class='scroll'></div>");
                    jQuery("#" + subgrid_table_id).jqGrid(
                        {
                            url : "${pageContext.request.contextPath}/user/findAllById?starId="+id,
                            datatype : "json",
                            colNames : [ 'id', '用户名','头像', '昵称','手机','签名','地址','性别','创建时间' ],
                            colModel : [
                                {name : "id",hidden:true},
                                {name : "username",align:"center"},
                                {name : "photo",align:"center",edittype:"file",formatter:function (value,option,rows) {
                                        return "<img style='width:100px;height:60px;' src='${pageContext.request.contextPath}/back/img/star/"+rows.photo+"'>";
                                    }},
                                {name : "nickname",align:"center"},
                                {name : "phone",align:"center"},
                                {name : "sign",align:"center"},
                                {name : "city",align:"center"},
                                {name : "sex",align:"center"},
                                {name : "createDate",align:"center"}
                            ],
                            styleUI:'Bootstrap',
                            rowNum : 3,
                            viewrecords : true,
                            autowidth:true,
                            pager : pager_id,
                            sortname : 'num',
                            sortorder : "asc",
                            height : '100%'
                        });
                    jQuery("#" + subgrid_table_id).jqGrid('navGrid',
                        "#" + pager_id, {
                            edit : false,
                            add : false,
                            del : false
                        });
                },

            });
        jQuery("#list").jqGrid(
            'navGrid',
            '#pager',
            {add : true,edit : true,del : true,search:false},{
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
                            url:"${pageContext.request.contextPath}/star/upload",
                            type:"post",
                            fileElementId:"photo",
                            data:{id:id},
                            success:function (response) {
                                //自动刷新jqgrid表格
                                $("#list").trigger("reloadGrid");
                            }
                        });
                    }
                    return "123";
                }
            }
            );
    });
</script>
<div class="page-header" >
    <h3 style="margin-top:-34px">展示所有明星</h3>
</div>
<%--创建表格--%>
<table id="list" ></table>
<%--分页--%>
<div id="pager" style="height: 40px;" ></div>