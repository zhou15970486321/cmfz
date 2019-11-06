<%@page pageEncoding="UTF-8" isELIgnored="false" %>
<script>

    $(function () {
        $("#list").jqGrid({
            url : '${pageContext.request.contextPath}/album/findAll',
            datatype : "json",
            colNames : [ '编号', '标题', '封面', '章节数', '得分','作者','专辑简介','创建时间'],
            colModel : [
                {name : 'id',hidden:true,editable:false,align:"center"},
                {name : 'title',editable:true,align:"center"},
                {name : 'cover',editable:true,edittype:"file",align:"center",formatter:function (value,option,rows) {
                        return "<img style='width:100px;height:60px;' src='${pageContext.request.contextPath}/back/img/album/"+rows.cover+"'>";
                    }},
                {name : 'count',align:"center"},
                {name : 'score',editable:true,align:"center"},
                {name : 'starId',editable:true,edittype:"select",
                        editoptions:{dataUrl:"${pageContext.request.contextPath}/star/queryAllStats"},
                        formatter:function (value,option,rows) {
                        return rows.star.name;}},
                {name : 'brief',editable:true,align:"center"},
                {name : 'createDate',align:"center"}
            ],
            height:400,
            autowidth:true,
            styleUI:"Bootstrap",
            rowNum : 5,
            rowList : [ 5,10,15 ],
            pager : '#pager',
            viewrecords : true,
            subGrid : true,
            caption : "轮播图列表",
            editurl : "${pageContext.request.contextPath}/album/edit",
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
                        url : "${pageContext.request.contextPath}/chapter/findAllByAlbumId?albumId="+id,
                        datatype : "json",
                        colNames : [ 'id', '章节名','大小', '时长','文件名','创建时间','在线播放' ],
                        colModel : [
                            {name : "id",hidden:true},
                            {name : "title",align:"center",editable:true},
                            {name : "size",align:"center"},
                            {name : "duration",align:"center"},
                            {name : "name",align:"center",editable:true,edittype:"file"},
                            {name : "createDate",align:"center"},
                            {name : "operation",width:250,formatter:function (value,option,rows) {
                                    return "<audio controls>\n" +
                                        "  <source src='${pageContext.request.contextPath}/back/img/chapter/"+rows.name+"' >\n" +
                                        "</audio>";
                                }}
                        ],
                        autowidth:true,
                        styleUI:'Bootstrap',
                        rowNum : 3,
                        pager : pager_id,
                        height : '100%',
                        editurl : "${pageContext.request.contextPath}/chapter/edit?albumId="+id
                    });
                jQuery("#" + subgrid_table_id).jqGrid(
                    'navGrid',
                    "#" + pager_id,
                    {edit : false, add : true, del : false, search: false},
                    {}, {
                    closeAfterAdd:true,
                    afterSubmit:function (response) {
                        var status = response.responseJSON.status;
                        alert(status);
                        if(status){
                            var cid = response.responseJSON.message;
                            $.ajaxFileUpload({
                                url:"${pageContext.request.contextPath}/chapter/upload",
                                type:"post",
                                fileElementId:"name",
                                data:{id:cid,albumId:id},
                                success:function () {
                                    //自动刷新jqgrid表格
                                    $("#"+subgrid_table_id).trigger("reloadGrid");
                                }
                            });
                        }
                        return "123";
                    }
                    }

                );
            },

        });
        $("#list").jqGrid(
            'navGrid',
            "#pager",
            {edit : true,add : true,del : true,search:false},
            {   //控制修改
                closeAfterEdit:true,
                beforeShowForm:function (fmt) {
                fmt.find("#cover").attr("disabled",true);}
            },
            {
            //控制添加
            closeAfterAdd:true,
            afterSubmit:function (data) {

                var status = data.responseJSON.status;
                var id = data.responseJSON.message;
                if(status){
                    $.ajaxFileUpload({
                        url:"${pageContext.request.contextPath}/album/upload",
                        type:"post",
                        fileElementId:"cover",
                        data:{id:cid},
                        success:function (response) {
                            //自动刷新jqgrid表格
                            $("#list").trigger("reloadGrid");
                        }
                    });
                }
                return "123";
            }
                })
    })

</script>
<div class="page-header" >
    <h3 style="margin-top:-34px">展示所有轮播图</h3>
</div>


<%--创建表格--%>
<table id="list" ></table>

<%--分页--%>
<div id="pager" style="height: 40px;" ></div>