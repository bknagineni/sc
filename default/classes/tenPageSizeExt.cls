public with sharing class tenPageSizeExt 
{
	public tenPageSizeExt(ApexPages.StandardSetController controller)
	{
		controller.setPageSize(10);
	}
}