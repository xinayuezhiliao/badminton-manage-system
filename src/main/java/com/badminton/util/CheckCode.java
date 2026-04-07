package com.badminton.util;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

public class CheckCode {
	private int width = 80;
	private int height = 30;
	private int codeCount = 4;
	private int lineCount = 20;
	private String code;

	public BufferedImage createImage() {
		BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		Graphics2D g = image.createGraphics();
		Random random = new Random();

		g.setColor(Color.WHITE);
		g.fillRect(0, 0, width, height);

		g.setColor(Color.BLACK);
		g.setFont(new Font("Arial", Font.BOLD, 20));

		char[] chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789".toCharArray();
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < codeCount; i++) {
			char c = chars[random.nextInt(chars.length)];
			sb.append(c);
			g.setColor(new Color(random.nextInt(255), random.nextInt(255), random.nextInt(255)));
			g.drawString(c + "", 15 * i + 10, 22);
		}
		code = sb.toString();

		for (int i = 0; i < lineCount; i++) {
			g.setColor(new Color(random.nextInt(255), random.nextInt(255), random.nextInt(255)));
			int x1 = random.nextInt(width);
			int y1 = random.nextInt(height);
			int x2 = random.nextInt(width);
			int y2 = random.nextInt(height);
			g.drawLine(x1, y1, x2, y2);
		}
		g.dispose();
		return image;
	}

	public String getCode() {
		return code;
	}

	public static void outputImage(BufferedImage image, OutputStream os) throws IOException {
		ImageIO.write(image, "JPEG", os);
	}
}