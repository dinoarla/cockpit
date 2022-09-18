<?php
function upload_pdf($filename, $source, $target){
	$target_path = $target.$filename; 
	move_uploaded_file($source, $target_path);
}
?>
