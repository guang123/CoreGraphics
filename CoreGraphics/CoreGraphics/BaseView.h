//
//  GraphView.h
//  CoreGraphics
//
//  Created by Yx on 15/12/31.
//  Copyright © 2015年 WuhanBttenMobileTechnologyCo.,Ltd. All rights reserved.
//
/*
 typedef CF_ENUM(int32_t, CGLineCap) {
 kCGLineCapButt,    线条结尾处什么都不做
 kCGLineCapRound,   线条结尾处绘制一个直径为线条宽度的半圆。
 kCGLineCapSquare   线条结尾处绘制半个边长为线条宽度的正方形
 };
 
 typedef CF_ENUM(int32_t, CGLineJoin) {
 kCGLineJoinMiter,
 kCGLineJoinRound,  线条接合点为圆角。
 kCGLineJoinBevel   线条接合点为斜角
 };
 
 kCGPathFill:只有填充（非零缠绕数填充），不绘制边框
 kCGPathEOFill:奇偶规则填充（多条路径交叉时，奇数交叉填充，偶交叉不填充）
 kCGPathStroke:只有边框
 kCGPathFillStroke：既有边框又有填充
 kCGPathEOFillStroke：奇偶填充并绘制边框
 
 */

/*********************************************************************************************
                        此处仅说属性与方法 原理之后提及
 
***************************CGContext属性与方法*************************************************
 CoreGraphics绘图 
 CoreGraphics是一个画家抽象类，CGContext（图形上下文）为画布，CGContext中的各种方法就是画笔。
 我们可以通过CGContextSetStrokeColorWithColor，CGContextSetLineWidth等方法来设置画笔的颜色与线条的宽度
 
 返回上下文类型标识 没发现有什么卵用
 CGContextGetTypeID
 
 使用Quartz时涉及到一个图形上下文，其中包含一个保存过的图形状态堆栈。
 在Quartz创建图形上下文时，该堆栈是空的。
 CGContextSaveGState函数的作用是将当前图形状态推入堆栈。之后，您对图形状态所做的修改会影响随后的描画操作，但不影响存储在堆栈中的拷贝。
 在修改完成后，您可以通过CGContextRestoreGState函数把堆栈顶部的状态弹出，返回到之前的图形状态。
 
 //保存当前图像上下文状态(线条颜色 粗线 等)
 CGContextSaveGState

 //回复图形上下文状态
 CGContextRestoreGState
 
 ***************************仿射变换
 缩放 sx sy 为x轴与y轴的缩放比例
 CGContextScaleCTM(CGContextRef __nullable c,CGFloat sx, CGFloat sy)
 
 平移 tx ty 为x轴与y轴的平移距离
 CGContextTranslateCTM(CGContextRef __nullable c,CGFloat tx, CGFloat ty)
 
 旋转 angle旋转角度 eg:CGContextRotateCTM (context, radians(-180.)); 旋转-180度
 CGContextRotateCTM(CGContextRef __nullable c, CGFloat angle)
 
 联合变换http://www.aichengxu.com/view/46588
 CGContextConcatCTM(CGContextRef __nullable c,CGAffineTransform transform)
 
 获取CGContextRef的坐标系统的变换矩阵。
 CGContextGetCTM(CGContextRef __nullable c)
 
 ***************************设置绘图属性功能
 设置线条宽度
 CGContextSetLineWidth(CGContextRef __nullable c, CGFloat width)
 
 设置线段首尾两端的样式，本属性将不影响闭合子路径
 CGContextSetLineCap(CGContextRef __nullable c, CGLineCap cap)
 
 设置设置线条连接点的样式
 CGContextSetLineJoin(CGContextRef __nullable c, CGLineJoin join)
 
 设置设置线条连接的斜连限制 当把连接点风格设为meter风格时，该方法用于控制锐角箭头的长度
 CGContextSetMiterLimit(CGContextRef __nullable c, CGFloat limit)
 
 绘制虚线 http://blog.csdn.net/zhangao0086/article/details/7234859
 CGContextSetLineDash(CGContextRef __nullable c, CGFloat phase,const CGFloat * __nullable lengths, size_t count)
 
 设置曲线的平滑度
 CGContextSetFlatness(CGContextRef __nullable c, CGFloat flatness)
 
 设置当前上下文透明度
 CGContextSetAlpha(CGContextRef __nullable c, CGFloat alpha)
 
 设置混合模式（上下文叠加时颜色混合的方式）
 CGContextSetBlendMode(CGContextRef __nullable c, CGBlendMode mode)
 
 ***************************构建路径
 创建新的子路径 可以将其引用存储在CGPathRef或CGMutablePathRef数据类型中
 CGContextBeginPath
 
 设置新子路径起始点 
 CGContextMoveToPoint(CGContextRef __nullable c,CGFloat x, CGFloat y)
 
 添加一条直线到子路径，直线终点为x y
 CGContextAddLineToPoint(CGContextRef __nullable c,CGFloat x, CGFloat y)
 
 添加三次贝塞尔曲线
 CGContextAddCurveToPoint(CGContextRef __nullable c, CGFloat cp1x,CGFloat cp1y, CGFloat cp2x, CGFloat cp2y, CGFloat x, CGFloat y)
 
 添加二次贝塞尔曲线
 CGContextAddQuadCurveToPoint(CGContextRef __nullable c,CGFloat cpx, CGFloat cpy, CGFloat x, CGFloat y)
 
 闭合当前子路径 （在闭合一条子路径后，如果程序再添加直线、弧或曲线到路径，Quartz将在闭合的子路径的起点开始创建一个子路径）
 CGContextClosePath(CGContextRef __nullable c)
 
 添加矩形到当前路径 CGRect为矩形位置及大小
 CGContextAddRect(CGContextRef __nullable c, CGRect rect)
 
 添加一系列的矩形到当前路径
 CGContextAddRects(CGContextRef __nullable c,const CGRect * __nullable rects, size_t count)
 
 添加一系列线条到当前路径 我们传递一个点数组给这个函数。第一个点必须是第一条直线的起始点；剩下的点是端点
 CGContextAddLines(CGContextRef __nullable c,const CGPoint * __nullable points, size_t count)
 
 添加一个椭圆到当前路径
 CGContextAddEllipseInRect(CGContextRef __nullable c, CGRect rect)
 
 添加弧线到当前路径 x,y: 开始画的坐标 radius: 半径 startAngle, endAngle: 开始的弧度,结束的弧度 clockwise: 画弧的方向(顺时针,逆时针)
 CGContextAddArc(CGContextRef __nullable c, CGFloat x, CGFloat y,CGFloat radius, CGFloat startAngle, CGFloat endAngle, int clockwise)
 
 添加弧到当前路径（根据两条相交线与半径确定圆弧位置 ，这里使用该函数画弧时还需确定一个起点CGContextMoveToPoint设置起点）
 CGContextAddArcToPoint(CGContextRef __nullable c,CGFloat x1, CGFloat y1, CGFloat x2, CGFloat y2, CGFloat radius)
 
 添加一条路径到当前上下文 直到绘制 创建的CGPathRef/CGMutablePathRef需要添加到路径中方可绘制
 CGContextAddPath(CGContextRef __nullable c,CGPathRef __nullable path)
 
 *************************** Path stroking
 使用绘制当前路径时覆盖的区域作为当前CGContextRef中的新路径。
        举例来说，假如当前CGContextRef包含一个圆形路径且线宽为10，调用该方法后，当前CGContextRef将包含一个环宽为10的环形路径
 CGContextReplacePathWithStrokedPath(CGContextRef __nullable c) 待实际编码验证
 
 表示当前的路径是否包含任何的子路径
 CGContextIsPathEmpty(CGContextRef __nullable c)
 
 返回一个非空的路径中的当前点
 CGContextGetPathCurrentPoint(CGContextRef __nullable c)
 
 返回包含当前路径的最小矩形
 CGContextGetPathBoundingBox(CGContextRef __nullable c)

 返回当前上下文的路径
 CGContextCopyPath(CGContextRef __nullable c)
 
 检查当前路径中是否包含指定的点
 CGContextPathContainsPoint(CGContextRef __nullable c,CGPoint point, CGPathDrawingMode mode)
 
 *************************** 绘制路径
 绘制路径 mode绘制模式
 CGContextDrawPath(CGContextRef __nullable c,CGPathDrawingMode mode)
 
 采用填充绘制路径
 CGContextFillPath(CGContextRef __nullable c)
 
 使用奇偶规则来填充该路径包围的区域。
            奇偶规则指：如果某个点被路径包围了奇数次，系统绘制该点；如果被路径包围了偶数次，系统不绘制
 CGContextEOFillPath(CGContextRef __nullable c)
 
 使用当前上下文设置的线宽绘制路径
 CGContextStrokePath(CGContextRef __nullable c)
 
 填充rect代表的矩形
 CGContextFillRect(CGContextRef __nullable c, CGRect rect)
 
 填充矩形数组中的矩形
 CGContextFillRects(CGContextRef __nullable c,const CGRect * __nullable rects, size_t count)
 
 使用当前上下文设置的线宽绘制矩形框
 CGContextStrokeRect(CGContextRef __nullable c, CGRect rect)
 
 指定线条宽度绘制矩形
 CGContextStrokeRectWithWidth(CGContextRef __nullable c,CGRect rect, CGFloat width)
 
 清除指定矩形区域上绘制的图形
 CGContextClearRect(CGContextRef __nullable c, CGRect rect)
 
 填充rect矩形的内切椭圆区域
 CGContextFillEllipseInRect(CGContextRef __nullable c,CGRect rect)
 
 使用当前上下文设置的线宽绘制rect矩形的内切椭圆
 CGContextStrokeEllipseInRect(CGContextRef __nullable c,CGRect rect)
 
 使用当前 CGContextRef设置的线宽绘制多条线段。该方法需要传入2N个CGPoint组成的数组，其中1、2个点组成第一条线段，3、4个点组成第2条线段，以此类推
 CGContextStrokeLineSegments(CGContextRef __nullable c,const CGPoint * __nullable points, size_t count)
 
 *************************** 裁剪功能
 
 将当前路径转换为裁剪路径
 CGContextClip(CGContextRef __nullable c)
 
 使用奇偶规则剪裁
 CGContextEOClip(CGContextRef __nullable c)
 
 使用矩形为边框剪裁图片
 CGContextClipToMask(CGContextRef __nullable c, CGRect rect,CGImageRef __nullable mask)
 
 获取裁剪的区域
 CGContextGetClipBoundingBox(CGContextRef __nullable c)
 
 裁剪一个矩形区域
 CGContextClipToRect(CGContextRef __nullable c, CGRect rect)
 
 裁剪一系列的矩形区域
 CGContextClipToRects(CGContextRef __nullable c,const CGRect *  rects, size_t count)
 
 *************************** 颜色
 
 填充颜色
 CGContextSetFillColorWithColor(CGContextRef __nullable c,CGColorRef __nullable color)
 
 设置线条颜色
 CGContextSetStrokeColorWithColor(CGContextRef __nullable c,CGColorRef __nullable color)
 
 设置填充颜色空间的填充颜色---->颜色空间http://southpeak.github.io/blog/2014/12/01/quartz-2dbian-cheng-zhi-nan-zhi-si-:yan-se-yu-yan-se-kong-jian/
 CGContextSetFillColorSpace(CGContextRef __nullable c,CGColorSpaceRef __nullable space)

 设置填充颜色空间的描边颜色
 CGContextSetStrokeColorSpace(CGContextRef __nullable c,CGColorSpaceRef __nullable space)

 使用Components设置填充色 CGContextSetFillColor(ctx, CGColorGetComponents( [[UIColor colorWithRed:99/255 green:184/255 blue:255/255 alpha:1 ] CGColor]))
 CGContextSetFillColor(CGContextRef __nullable c,const CGFloat * __nullable components)
 
 使用Components设置描边颜色
 CGContextSetStrokeColor(CGContextRef __nullable c,const CGFloat * __nullable components)
 
 *************************** 模式功能
 模式概念及应用http://www.cnblogs.com/kenshincui/p/3959951.html
 自定义填充模式：一种颜色的填充方式。通过绘制一个基本的颜色模板，以该模板填充指定区域
 类型：有色填充，无色填充。有色填充先指定模板的颜色后绘制；无色填充是先绘制然后在绘制中填充模板颜色
 
 设置颜色填充模式
 CGContextSetFillPattern(CGContextRef __nullable c,CGPatternRef __nullable pattern, const CGFloat * __nullable components)
 
 设置描边颜色填充模式
 CGContextSetStrokePattern(CGContextRef __nullable c,CGPatternRef __nullable pattern, const CGFloat * __nullable components)
 
 设置模板定位
 CGContextSetPatternPhase(CGContextRef __nullable c, CGSize phase)
 
 设置填充灰度
 CGContextSetGrayFillColor(CGContextRef __nullable c,CGFloat gray, CGFloat alpha)
 
 设置描边灰度
 CGContextSetGrayStrokeColor(CGContextRef __nullable c,CGFloat gray, CGFloat alpha)
 
 设置RBG填充颜色
 CGContextSetRGBFillColor(CGContextRef __nullable c, CGFloat red,CGFloat green, CGFloat blue, CGFloat alpha)
 
 使用RGB描边
 CGContextSetRGBStrokeColor(CGContextRef __nullable c,CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha)
 
 设置CMYK填充颜色
 CGContextSetCMYKFillColor(CGContextRef __nullable c,CGFloat cyan, CGFloat magenta, CGFloat yellow, CGFloat black, CGFloat alpha)
 
 设置CMYB描边
 CGContextSetCMYKStrokeColor(CGContextRef __nullable c,CGFloat cyan, CGFloat magenta, CGFloat yellow, CGFloat black, CGFloat alpha)
 
 设置渲染意向
 CGContextSetRenderingIntent(CGContextRef __nullable c,CGColorRenderingIntent intent)
 CGContextSetRenderingIntent，默认kCGRenderingIntentDefault
 － 视觉匹配：不同设备输出在视觉上保持一致。 kCGRenderingIntentPerceptual
 － 相对色阶匹配：kCGRenderingIntentRelativeColorimetric
 － 饱和度匹配：kCGRenderingIntentSaturation
 － 绝对色阶匹配：kCGRenderingIntentAbsoluteColorimetric
 
 *************************** 阴影
 
 设置阴影 offset偏移量 blur模糊值  color颜色
 CGContextSetShadowWithColor(CGContextRef __nullable c,CGSize offset, CGFloat blur, CGColorRef __nullable color)
 
 设置阴影
 CGContextSetShadow(CGContextRef __nullable c, CGSize offset,CGFloat blur）
 
 线性颜色渐变http://www.cnblogs.com/pengyingh/articles/2378840.html（渐变需设置颜色空间）
 CGContextDrawLinearGradient(CGContextRef __nullable c,CGGradientRef __nullable gradient, CGPoint startPoint, CGPoint endPoint,CGGradientDrawingOptions options)
 
 仿射状颜色渐变
 CGContextDrawRadialGradient(CGContextRef __nullable c,CGGradientRef __nullable gradient, CGPoint startCenter, CGFloat startRadius,CGPoint endCenter, CGFloat endRadius, CGGradientDrawingOptions options)
 
 使用渐变来绘制上下文的裁减区域http://www.tuicool.com/articles/biieum
 CGContextDrawShading(CGContextRef __nullable c,__nullable CGShadingRef shading)
 
 *************************** 文字
 文字间距
 CGContextSetCharacterSpacing(CGContextRef __nullable c,CGFloat spacing)
 
 文字位置
 CGContextSetTextPosition(CGContextRef __nullable c,CGFloat x, CGFloat y)
 
 获取文字位置
 CGContextGetTextPosition(CGContextRef __nullable c)
 
 设置文字映射
 CGContextSetTextMatrix(CGContextRef __nullable c,CGAffineTransform t)
 
 获取文字映射矩阵
 CGContextGetTextMatrix(CGContextRef __nullable c)
 
 设置文字绘制模式
 CGContextSetTextDrawingMode(CGContextRef __nullable c,CGTextDrawingMode mode)
 
 设置字体大小
 CGContextSetFont(CGContextRef __nullable c,CGFontRef __nullable font)
 
 设置文字宽高
 CGContextSetFontSize(CGContextRef __nullable c, CGFloat size)
 
 设置文字绘制的位置
 CGContextShowGlyphsAtPositions(CGContextRef __nullable c,const CGGlyph * __nullable glyphs, const CGPoint * __nullable Lpositions,size_t count)
 
 设置是否应该字体平滑
 CGContextSetShouldSmoothFonts(CGContextRef __nullable c,bool shouldSmoothFonts)
 CGContextSetAllowsFontSmoothing(CGContextRef __nullable c,bool allowsFontSmoothing)
 
 CGContextSetShouldSubpixelPositionFonts(CGContextRef __nullable c, bool shouldSubpixelPositionFonts)
 CGContextSetAllowsFontSubpixelPositioning(CGContextRef __nullable c, bool allowsFontSubpixelPositioning)
 
 CGContextSetShouldSubpixelQuantizeFonts(CGContextRef __nullable c, bool shouldSubpixelQuantizeFonts)
 
 
 *************************** 管理图形上下文
 CGContextFlush       强制所有挂起的绘图操作在一个窗口上下文中立即被渲染到目标设备。
 CGContextGetTypeID   返回Quartz图形上下文的类型标识符。
 CGContextRelease     图形上下文的引用计数-1。
 CGContextRetain      图形上下文的引用计数+1。
 CGContextSynchronize 将一个窗口的图像上下文内容更新，即所有的绘图操作都会在下次同步到窗口上
 
*************************** 保真 用于抗锯齿
 允许保真
 CGContextSetAllowsAntialiasing(CGContextRef __nullable c,bool allowsAntialiasing)

 设置保真
 CGContextSetShouldAntialias(CGContextRef __nullable c,bool allowsAntialiasing)
 
 *************************** 透明层 http://blog.csdn.net/rhljiayou/article/details/10144993
 
 绘制一个透明层
 CGContextBeginTransparencyLayer(CGContextRef __nullable c,CFDictionaryRef __nullable auxiliaryInfo)
 CGContextBeginTransparencyLayerWithRect(CGContextRef __nullable c, CGRect rect, CFDictionaryRef __nullable auxInfo)
 
 关闭透明层
 CGContextEndTransparencyLayer(CGContextRef __nullable c)
 ********************************************************************************************/
#import <UIKit/UIKit.h>

@interface BaseView : UIView{
    float viewH;//当前视图宽
    float viewW;//当前视图高
}

//开始绘制表格
- (void)startDraw;

@end
