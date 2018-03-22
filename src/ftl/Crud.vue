<template>
    <div class="animated fadeIn">
        <div>
        <Row style="margin-bottom: 25px;">
        <Col span="8">${entityRemark}：
        <Input v-model="keyWord" placeholder="请输入..." style="width:200px"/>
        </Col>
        <Col span="8"><Button type="primary" shape="circle" icon="ios-search" @click="gopage()">搜索</Button></Col>
        </Row>
        </div>
        <div>
            <ul>
                <li>
                    <Button type="primary" icon="plus-round" @click="add${className}()">新建</Button>
                    <Button type="success" icon="wrench" @click="edit()">修改</Button>
                    <Button type="error" icon="trash-a" @click="remove()">删除</Button>
                </li>
                <li>
                    <div style="padding: 10px 0;">
                        <Table border :columns="columns1" :data="data1" @on-selection-change="s=>{change(s)}"></Table>
                    </div>
                </li>
                <li>
                    <div style="text-align: right;">
                        <Page :total="totalCount" :page-size="pageSize" :current="pageNo" @on-change="gopage"
                              align="center"></Page>
                    </div>
                </li>
            </ul>
        </div>

        <Modal
                v-model="addModal"
                title="添加${entityRemark}"
                :mask-closable="false"
                :loading="loading"
                @on-ok="add"
                @on-cancel="cancel"
                width="60%">
            <Form ref="addForm" :model="addForm" :rules="ruleCustom" :label-width="80">
                <!--一次性取两个元素放在row集合中 -->
                <#list properties?chunk(2) as row>
                    <Row>
                        <!-- 循环便利row中的两个元素-->
                        <#list row as pro>
                            <Col span="11">
                            <FormItem label="<#if pro.proComment ??>${pro.proComment}</#if>" prop="${pro.proName}">
                                <Input type="text" v-model="addForm.${pro.proName}"/>
                            </FormItem>
                            </Col>
                            <#if pro_index==0>
                                <Col span="2" style="text-align: center"/>
                            </#if>
                        </#list>
                    </Row>
                </#list>
            </Form>
        </Modal>


        <Modal
                v-model="updateModal"
                title="编辑${entityRemark}"
                :mask-closable="false"
                :loading="loading"
                @on-ok="update"
                @on-cancel="cancel"
                width="60%">
            <Form ref="updateForm" :model="updateForm" :rules="ruleCustom" :label-width="80">

                <#list properties?chunk(2) as row>
                    <Row>
                        <#list row as pro>
                            <Col span="11">
                            <FormItem label="<#if pro.proComment ??>${pro.proComment}</#if>" prop="${pro.proName}">
                                <Input type="text" v-model="updateForm.${pro.proName}"/>
                            </FormItem>
                            </Col>
                            <#if pro_index==0>
                                <Col span="2" style="text-align: center"/>
                            </#if>
                        </#list>
                    </Row>
                </#list>

            </Form>
        </Modal>
    </div>
</template>

<script type="text/ecmascript-6">
    import fetch from 'utils/fetch';
    import {dateFormat} from 'utils/date';

    export default {
        data() {
            return {
                loading:true,
                count: 0,
                gourpId: null,
                pageSize: 20,
                pageNo: 1,
                totalPage: 0,
                totalCount: 0,
                keyWord:"",
                columns1: [
                    {
                        type: 'selection',
                        width: 60,
                        align: 'center'
                    },
                <#list properties as pro>
            <#-- 排除几个字段 -->
            <#if pro.primary?string('yes', 'no')=="no">
            <#if "createBy,createDept,createTime,updateBy,updateTime"?index_of(pro.proName) == -1>
                    {
                        title: '<#if pro.proComment ??>${pro.proComment}</#if>',
                        key: '${pro.proName}'
                    }<#if pro_index+1 lt properties?size>,</#if>
                    </#if>
            </#if>
            </#list>
                ],
                self: this,
                data1: [],
                updateModal: false,
                addModal: false,
                updateForm: {
                    <#list properties as pro>
                    <#if pro.primary>
                        id:"",
                    </#if>
                    <#-- 排除几个字段 -->
                    <#if pro.primary?string('yes', 'no')=="no">
                    <#if "createBy,createDept,createTime,updateBy,updateTime"?index_of(pro.proName) == -1>
                        ${pro.proName}:""<#if pro_index+1 lt properties?size>,</#if>
                    </#if>
                    </#if>
                    </#list>
                },
                addForm: {
                <#list properties as pro>
                    <#-- 排除几个字段 -->
                    <#if pro.primary?string('yes', 'no')=="no">
                    <#if "createBy,createDept,createTime,updateBy,updateTime"?index_of(pro.proName) == -1>
                        ${pro.proName}:""<#if pro_index+1 lt properties?size>,</#if>
                    </#if>
                    </#if>
                </#list>
                },
                ruleCustom: {
                <#list properties as pro>
                    ${pro.proName}: [
                        {required: true, message:'<#if pro.proComment ??>${pro.proComment}</#if>不能为空',trigger:'blur'}
                    ]
                    <#if pro_index+1 lt properties?size>
                    ,
                    </#if>
                </#list>
                }
            }
        },
        methods: {
            change(e){
                if (e.length == 1) {
                    this.updateForm = e[0];
                }
                this.setGroupId(e);
            },
            setGroupId(e)
            {
                this.groupId = [];
                this.count = e.length;
                for (var i = 0; i < e.length; i++) {
                    this.groupId.push(e[i].id);
                }
            },
            reset(form){
                this.$refs[form].resetFields();
            },
            add${className }(){
                this.addModal = true;
            },
            add(){
                this.$refs['addForm'].validate((valid)=>{
                    if(valid)
                    {
                        const ${className?uncap_first} = this.addForm;
                        fetch({
                            url: '/${rootPath}/${className?uncap_first}',
                            method: 'post',
                            data: dept
                        }).then((result) => {
                            this.gopage(this.pageNo);
                            this.$refs['addForm'].resetFields();
                            this.$Message.success('Success!');
                            this.addModal = false;
                        });
                    }
                    else
                    {
                        this.$Message.error("表单验证失败");
                        setTimeout(()=>{
                            this.loading=false;
                            this.$nextTick(()=>{
                                this.loading=true;
                            });
                        },1000);
                    }
                })
            },
            edit () {
                if (this.count != 1) {
                    this.updateModal = false;
                    this.$Message.warning('请至少并只能选择一项');
                }
                else {
                    this.updateModal = true;
                }
            },
            update () {
                this.$refs['updateForm'].validate((valid)=>{
                    if(valid)
                    {
                        fetch({
                            url: '/${rootPath}/${className?uncap_first}',
                            method: 'put',
                            data: this.updateForm
                        }).then((result) => {
                            this.updateModal = false,
                                    this.$Message.success('Success!');
                            this.gopage(this.pageNo);
                        });
                    }
                    else
                    {
                        this.$Message.error("表单验证失败");
                        setTimeout(()=>{
                            this.loading=false;
                            this.$nextTick(()=>{
                                this.loading=true;
                            });
                        },1000);
                    }
                })
            },
            remove () {
                if (this.groupId != null && this.groupId != "") {
                    fetch({
                        url: '/${rootPath}/${className?uncap_first}',
                        method: 'delete',
                        data: this.groupId
                    }).then((result) => {
                        if (result.data == '1') {
                            this.$Message.success('Success!');
                            this.gopage(this.pageNo);
                        }
                    });
                } else {
                    this.$Message.warning('请至少选择一项');
                }
            },
            gopage(){
                const pageNo = this.pageNo;
                const pageSize = this.pageSize;
                const keyWord = this.keyWord;
                fetch({
                    url: '/${rootPath}/${className?uncap_first}',
                    method: 'get',
                    params: {pageNo, pageSize,keyWord}
                }).then((result) => {
                    this.data1 = result.data.list;
                    this.pageNo = pageNo;
                    this.pageSize = pageSize;
                    this.totalCount = result.data.totalCount;
                });
            },
            cancel () {
                this.$Message.info('点击了取消');
            }
        },
        mounted: function () {
            this.gopage();
        }
    }


</script>