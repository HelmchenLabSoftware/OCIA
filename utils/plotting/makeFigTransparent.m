function makeFigTransparent(figH, alphaVal)

jFig = get(handle(figH), 'JavaFrame');
jFigWin = jFig.fFigureClient.getWindow();
com.sun.awt.AWTUtilities.setWindowOpacity(jFigWin, alphaVal);

end