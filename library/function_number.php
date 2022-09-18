<?php
    function easy_number($n) {
        // first strip any formatting;
        $n = (0+str_replace(",","",$n));
        
        // is this a number?
        if(!is_numeric($n)) return false;
        
        // now filter it;
        if($n>1000000000000) return round(($n/1000000000000),2).' T';
        else if($n>1000000000) return round(($n/1000000000),2).' G';
        else if($n>1000000) return round(($n/1000000),2).' M';
        else if($n>1000) return round(($n/1000),2).' k';
        
        return number_format($n);
    }
?>

<?php
    function easy_number_rp($n) {
        // first strip any formatting;
        $n = (0+str_replace(",","",$n));
        
        // is this a number?
        if(!is_numeric($n)) return false;
        
        // now filter it;
        if($n>1000000000000) return round(($n/1000000000000),0).' Trilyun';
        else if($n>1000000000) return round(($n/1000000000),0).' Milyar';
        else if($n>1000000) return round(($n/1000000),0).' Jt';
        else if($n>1000) return round(($n/1000),0).' Rb';
        
        return number_format($n);
    }
?>

<?php
    function easy_number_rp2($n) {
        // first strip any formatting;
        $n = (0+str_replace(",","",$n));
        
        // is this a number?
        if(!is_numeric($n)) return false;
        
        // now filter it;
        if($n>1000000000000) return round(($n/1000000000000),1).' Trilyun';
        else if($n>1000000000) return round(($n/1000000000),1).' Milyar';
        else if($n>1000000) return round(($n/1000000),1).' Jt';
        else if($n>1000) return round(($n/1000),1).' Rb';
        
        return number_format($n);
    }
?>