package ${ package }.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

<#import "CopyRight.ftl" as my>
<@my.CopyRight/>
public class ${ className } extends BaseEntity {
	private static final long serialVersionUID = 1L;
	private String id;
<#list properties as pro>  
	private ${pro.proType} ${pro.proName};			<#if pro.proComment ??>//${pro.proComment}</#if>
</#list>

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
<#list properties as pro>
	<#-- 对常用的几个字段不生成，已经继承BaseEntity -->  
	<#if pro.primary?string('yes', 'no')=="no">
	<#if "createBy,createDept,createTime,updateBy,updateTime"?index_of(pro.proName) == -1>
	public ${pro.proType} get${pro.proName?cap_first}() {
		return this.${pro.proName};
	}
	public void set${pro.proName?cap_first}(${pro.proType} ${pro.proName}) {
		this.${pro.proName} = ${pro.proName};
	}	
	</#if>
	</#if>
</#list>
}
