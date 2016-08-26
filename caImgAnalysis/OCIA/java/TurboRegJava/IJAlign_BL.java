import java.io.*;
import java.awt.image.*;
import ij.*;
import ij.io.*;
import ij.gui.*;
import ij.process.*;
import ij.plugin.PlugIn;
import ij.measure.*;

public class IJAlign_BL implements PlugIn
{
	
        public double[][][] targetPoints;
        public double[][][] sourcePoints;


        public IJAlign_BL() {;}
        
        public ImagePlus doAlign(String cmdStr, ImagePlus source, ImagePlus target) { 
        
            TurboReg_AK tr = new TurboReg_AK();

            // get the number of slices
            int nSlices = source.getNSlices();

            // init the target and source points for each slice with max 4 points and 2 coordinate values (X and Y)
            targetPoints = new double[nSlices][4][2];
            sourcePoints = new double[nSlices][4][2];

            // loop through all slices
            for (int i = 0; i < nSlices; i++) {
                source.setSlice(i + 1);
                ImagePlus sourceSlice = new ImagePlus("", source.getProcessor());
                tr.run(cmdStr, sourceSlice, target);
                ImagePlus alignedSlice = tr.getTransformedImage();
                alignedSlice.setSlice(1);
                source.setProcessor("aligned", alignedSlice.getProcessor());

                // get source target points
	        for (int j = 0; j < 4; j++) {
	            for (int k = 0; k < 2; k++) {
		        targetPoints[i][j][k] = tr.getTargetPoints()[j][k];
		        sourcePoints[i][j][k] = tr.getSourcePoints()[j][k];
	            }
		}

            }
            
            source.setSlice(1);
            
            return source;
        }
        
        public void run(String arg) {;}
}