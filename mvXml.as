package  {
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.*;
	import fl.controls.*;
	import fl.video.*;
	
	public class mvXml extends MovieClip {
		var xmlLoader:URLLoader = new URLLoader();
		var xmlData:XML = new XML();
		var flvAr:Array = new Array();
		var a:int=0;
		var fs:int=0;
		public function mvXml() {
			
		xmlLoader.load(new URLRequest("videoList.xml"));
		xmlLoader.addEventListener(Event.COMPLETE,LoadXML);
		
		addBtn.addEventListener(MouseEvent.CLICK,addList);
		remBtn.addEventListener(MouseEvent.CLICK,removeList);
		clsBtn.addEventListener(MouseEvent.CLICK,clearAll);
		
		
		playList.addEventListener(MouseEvent.DOUBLE_CLICK,chooseSong);
		playZone.addEventListener(Event.COMPLETE,nextSong);
		
		//playList2.addItem({label:flvAr[0].title,source:flvAr[0].temp});
		}//end constructor
		
		
		private function LoadXML(e:Event):void{
			xmlData = new XML(e.target.data);
			var i:int=0;
			
			while(xmlData.flv[i]){
				flvAr[i]= new Object();
				flvAr[i].id = xmlData.flv[i].@id;
				flvAr[i].title = xmlData.flv[i].title;
				flvAr[i].owner = xmlData.flv[i].owner;
				flvAr[i].details = xmlData.flv[i].details;
				flvAr[i].url = xmlData.flv[i].url;
				flvAr[i].temp = xmlData.flv[i].temp;
				i++;
			}
			
			addCombo();
			
		}//end loadXML
		
		public function addCombo()
		{
			for(var i:int=0;i<flvAr.length;i++)
			{allSong.addItem({label:flvAr[i].title,data:i});
			}
		}
		
		private function changeHandler(e:Event)
		{ComboBox(e.target).selectedItem.data;
		}
		
		public function addList(e:Event)
		{
			var c:int = allSong.selectedItem.data;
			playList.addItem({label:flvAr[c].title,id:flvAr[c].id,source:flvAr[c].temp});
			//playList2.addItem({label:flvAr[c].title,source:flvAr[c].temp});
		
			if(fs==0)
			{var f=playList.getItemAt(0).id;
			fs=1;
			playZone.source = flvAr[f].url;
			titleTxt.text =  flvAr[f].title;
			ownTxt.text =  flvAr[f].owner;
			detailTxt.text =  flvAr[f].details;}
			
		}
		
		public function removeList(e:Event)
		{
			playList.removeItemAt(playList.selectedIndex);
			
			
		}
		private function clearAll(e:Event)
		{
			playList.removeAll();
			fs=0;
		}
		
		
		
		private function chooseSong(e:Event)
		{
			
			var f:int =	playList.selectedItem.id;
			playZone.source = flvAr[f].url;
			titleTxt.text =  flvAr[f].title;
			ownTxt.text =  flvAr[f].owner;
			detailTxt.text =  flvAr[f].details;
		}
		
		private function nextSong(e:Event)
		{
			if(playList.selectedIndex+1<playList.length)
			{playList.selectedIndex++;}
			
			else
			{playList.selectedIndex=0;}
			
			var f:int =	playList.selectedItem.id;
			playZone.source = flvAr[f].url;
			titleTxt.text =  flvAr[f].title;
			ownTxt.text =  flvAr[f].owner;
			detailTxt.text =  flvAr[f].details;
			
			
		}
		
	}//end class
	
}//end package
