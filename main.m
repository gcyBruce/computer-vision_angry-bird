clear all
close all
%%%%%%%%%
% Please uncomment the following part(from 1 to 6) based on your test.
% Only comment one part out in each test to avoid some unpredictable matlab issues
%%%%%%%%%
% 1. if you test frame number from 428 to 493 (1st red bird), uncomment this part
%load("rb_map.mat");
%load("1st_redbird_curve.mat");

% 2. if you test frame number from 714 to 784 (blue bird), uncomment this part
%load('blue_map.mat');
%load('blue1_map.mat');
%load('blue2_map.mat');
%load('blue3_map.mat');
%load('bluebird_curve.mat');

% 3. if you test frame number from 892 to 934 (yellow bird), uncomment this part
%load("yb_map.mat");
%load("yellowbird_curve.mat");

% 4. if you test frame number from 1382 to 1444 (white bird), uncomment this part
%load("wb_map.mat");
%load("whitebird_curve2.mat");
%load("whitebird_curve.mat");

% 5. if you test frame number from 1126 to 1177 (black bird), uncomment this part
%load("black_map.mat");
%load("blackbird_curve.mat");

% 6. if you test frame number from 1688 to 1715 (2nd red bird), uncomment this part
load("2nd_redbird_curve.mat");
load("rb2_map.mat");

for frame_num = 1688:1715 % choose the frames that you want to test
have_yellow_bird = (frame_num <= 934) && (frame_num >= 892); 
have_red_bird = (frame_num <= 493 && frame_num >= 428) || (frame_num >=1688 && frame_num <=1715);
have_black_bird = (frame_num <= 1177) && (frame_num >= 1126);
have_slingshot = (frame_num >= 350 && frame_num <=441) || (frame_num >=660 && frame_num <=725) || (frame_num >= 859 && frame_num <=903) || (frame_num >=1105 && frame_num <=1137) || (frame_num >= 1337 && frame_num <=1395) || (frame_num >=1679 && frame_num <=1699);
have_blue_bird = (frame_num<= 784) && (frame_num >= 714);
have_white_bird = (frame_num<= 1444) && (frame_num >= 1382);

frame_path = ['./HSV_frames/',num2str(frame_num),'.jpg'];
frame = imread(frame_path);

save_path = ['./result/', num2str(frame_num),'.jpg'];

if have_yellow_bird || have_red_bird || have_black_bird || have_slingshot|| have_blue_bird || have_white_bird
    RGB_path = ['./RGB_frames/',num2str(frame_num),'.jpg'];
    figure,imshow(RGB_path),
    hold on
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% detect birds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if position = [0,0], it means the object is not detected in this frame
%detect yellow bird
if have_yellow_bird
    position_yb = detect_yb(frame, frame_num);
end
% detect red bird
if have_red_bird
    position_rb = detect_rb(frame, frame_num);
end
% detect blue bird
if have_blue_bird
    position_bb = detect_blue(frame, frame_num);
end

% detect white bird
if have_white_bird
    position_wb = detect_white(frame, frame_num);
end

%detect black bird
if have_black_bird
    position_black = detect_black(frame, frame_num);
end

%detect slingshot 6
if have_slingshot
    position_ss = detect_slingshot(frame, frame_num);
end
%hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% track birds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculate
% track the second red bird
% if have_red_bird && (frame_num >=1688 && frame_num <=1715)
%     % calculate curve when the slingshot occurs
%     if have_slingshot
%         if position_ss(1)*position_ss(2)*position_rb(1)*position_rb(2) ~=0
%             newx = position_rb(1) - position_ss(1);
%             newy = position_rb(2) - position_ss(2);
%             rb2_x_coordination_havess = [rb2_x_coordination_havess, newx];
%             rb2_y_coordination_havess = [rb2_y_coordination_havess, newy];
%         end
%     end
% end
% 
% % track the first red bird
% if have_red_bird && (frame_num <= 493 && frame_num >= 428)
%     % calculate curve when the slingshot occurs
%     if have_slingshot
%         if position_ss(1)*position_ss(2)*position_rb(1)*position_rb(2) ~=0
%             newx = position_rb(1) - position_ss(1);
%             newy = position_rb(2) - position_ss(2);
%             rb1_x_coordination_havess = [rb1_x_coordination_havess, newx];
%             rb1_y_coordination_havess = [rb1_y_coordination_havess, newy];
%         end
%     end
% end
% % track yellow bird
% if have_yellow_bird && have_slingshot
%     % calculate curve when the slingshot occurs
%     if position_ss(1)*position_ss(2)*position_yb(1)*position_yb(2) ~=0
%        newx = position_yb(1) - position_ss(1);
%        newy = position_yb(2) - position_ss(2);
%        yb_x_coordination_havess = [yb_x_coordination_havess, newx];
%        yb_y_coordination_havess = [yb_y_coordination_havess, newy];
%     end
% end
% % track black bird
% if have_black_bird && have_slingshot
%     % calculate curve when the slingshot occurs
%     if position_ss(1)*position_ss(2)*position_black(1)*position_black(2) ~=0
%        newx = position_black(1) - position_ss(1);
%        newy = position_black(2) - position_ss(2);
%        black_x_coordination_havess = [black_x_coordination_havess, newx];
%        black_y_coordination_havess = [black_y_coordination_havess, newy];
%     end
% end
% 
% % track white bird
% if have_white_bird && have_slingshot && frame_num <= 1428
%     % calculate curve when the slingshot occurs
%     if position_ss(1)*position_ss(2)*position_wb(1)*position_wb(2) ~=0
%        newx = position_wb(1) - position_ss(1);
%        newy = position_wb(2) - position_ss(2);
%        wb1_x_coordination_havess = [wb1_x_coordination_havess, newx];
%        wb1_y_coordination_havess = [wb1_y_coordination_havess, newy];
%     end
% end
% 
% if have_white_bird && frame_num >= 1429
%     % calculate curve when the slingshot occurs
%     if position_wb(1)*position_wb(2) ~=0
%        newx = position_wb(1) - 142;
%        newy = position_wb(2) - 94;
%        wb2_x_coordination_havess = [wb2_x_coordination_havess, newx];
%        wb2_y_coordination_havess = [wb2_y_coordination_havess, newy];
%     end
% end
% % track blue bird
% if have_blue_bird && have_slingshot && frame_num <=762
%     % calculate curve when the slingshot occurs
%     if position_ss(1)*position_ss(2)*position_bb(1)*position_bb(2) ~=0
%        newx = position_bb(1) - position_ss(1);
%        newy = position_bb(2) - position_ss(2);
%        bb_x_coordination_havess = [bb_x_coordination_havess, newx];
%        bb_y_coordination_havess = [bb_y_coordination_havess, newy];
%     end
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% draw curves
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if have_red_bird && (frame_num >=1688 && frame_num <=1715)
    fitted = zeros(480,2);
    for j = 1:480
        fitted(j,1) = j;
        fitted(j,2) = -rb2_coeff(1)*j^2 + rb2_coeff(2)*j + rb2_coeff(3)+rb2_M(frame_num);
    end
    plot(fitted(:,1),fitted(:,2),'-','linewidth',0.5);
    text (position_rb(1)-30,position_rb(2)+25,strcat('y =',num2str(-rb2_coeff(1)),' *x^2 + ', num2str(rb2_coeff(2)),' *x + ', num2str(rb2_coeff(3)+rb2_M(frame_num))),'FontSize', 7);
end

if have_yellow_bird
    fitted = zeros(480,2);
    for j = 1:480
        fitted(j,1) = j;
        fitted(j,2) = yb_coeff(1)*j^2 + yb_coeff(2)*j + yb_coeff(3)+yb_M(frame_num);
    end
    plot(fitted(:,1),fitted(:,2),'-','linewidth',0.5);
    text (position_yb(1)-30,position_yb(2)+25,strcat('y =',num2str(yb_coeff(1)),' *x^2 + ', num2str(yb_coeff(2)),' *x + ', num2str(yb_coeff(3)+yb_M(frame_num))),'FontSize', 7);
end

if have_red_bird && (frame_num <= 493 && frame_num >= 428)
    fitted = zeros(480,2);
    for j = 1:480
        fitted(j,1) = j;
        fitted(j,2) = rb1_coeff(1)*j^2 + rb1_coeff(2)*j + rb1_coeff(3)+rb_M(frame_num);
    end
    plot(fitted(:,1),fitted(:,2),'-','linewidth',0.5);
    text (position_rb(1)-30,position_rb(2)+25,strcat('y =',num2str(rb1_coeff(1)),' *x^2 + ', num2str(rb1_coeff(2)),' *x + ', num2str(rb1_coeff(3)+rb_M(frame_num))),'FontSize', 7);
end

if have_black_bird
    fitted = zeros(480,2);
    for j = 1:480
        fitted(j,1) = j;
        fitted(j,2) = black_coeff(1)*j^2 + black_coeff(2)*j + black_coeff(3) + black_M(frame_num);
    end
    plot(fitted(:,1),fitted(:,2),'-','linewidth',0.5);
    text (position_black(1)-30,position_black(2)+25,strcat('y =',num2str(black_coeff(1)),' *x^2 + ', num2str(black_coeff(2)),' *x + ', num2str(black_coeff(3) + black_M(frame_num))),'FontSize', 7);
end


if have_white_bird && frame_num <= 1428
    fitted = zeros(480,2);
    for j = 1:480
        fitted(j,1) = j;
        fitted(j,2) = wb_coeff(1)*j^2 + wb_coeff(2)*j + wb_coeff(3) + wb_M(frame_num);
    end
    plot(fitted(:,1),fitted(:,2),'-','linewidth',0.5);
    text (position_wb(1)-30,position_wb(2)+25,strcat('y =',num2str(wb_coeff(1)),' *x^2 + ', num2str(wb_coeff(2)),' *x + ', num2str(wb_coeff(3) + wb_M(frame_num))),'FontSize', 7);
end
if have_white_bird && frame_num >= 1429
    fitted = zeros(480,2);
    for j = 1:480
        fitted(j,1) = j;
        fitted(j,2) = wb2_coeff(1)*j^2 + wb2_coeff(2)*j + wb2_coeff(3) + wb_M(frame_num);
    end
    plot(fitted(:,1),fitted(:,2),'-','linewidth',0.5);
    text (position_wb(1)-50,position_wb(2)+25,strcat('y =',num2str(wb2_coeff(1)),' *x^2 + ', num2str(wb2_coeff(2)),' *x + ', num2str(wb2_coeff(3) + wb_M(frame_num))),'FontSize', 7);
end
if have_blue_bird && (frame_num >=714 && frame_num <=762)
    fitted = zeros(480,2);
    for j = 1:480
        fitted(j,1) = j;
        fitted(j,2) = bb_coeff(1)*j^2 + bb_coeff(2)*j + bb_coeff(3)+bb_M(frame_num);
    end
    plot(fitted(:,1),fitted(:,2),'-','linewidth',0.5);
    text (position_bb(1,1)-30,position_bb(1,2)+25,strcat('y =',num2str(-bb_coeff(1)),' *x^2 + ', num2str(bb_coeff(2)),' *x + ', num2str(bb_coeff(3)+bb_M(frame_num))),'FontSize', 7);
end
if have_blue_bird && (frame_num >=764 && frame_num <=784)
    fitted1 = zeros(480,2);
    fitted2 = zeros(480,2);
    fitted3 = zeros(480,2);
    for j = 1:480
        fitted1(j,1) = j;
        fitted2(j,1) = j;
        fitted3(j,1) = j;
        fitted1(j,2) = bb1_coeff(1)*j^2 + bb1_coeff(2)*j + bb1_coeff(3)+bb1_M(frame_num);
        fitted2(j,2) = bb2_coeff(1)*j^2 + bb2_coeff(2)*j + bb2_coeff(3)+bb2_M(frame_num);
        fitted3(j,2) = bb3_coeff(1)*j^2 + bb3_coeff(2)*j + bb3_coeff(3)+bb3_M(frame_num);
    end
    plot(fitted1(:,1),fitted1(:,2),'-','linewidth',0.5);
    text (position_bb(1,1)-30,position_bb(1,2)+25,strcat('y =',num2str(-bb1_coeff(1)),' *x^2 + ', num2str(bb1_coeff(2)),' *x + ', num2str(bb1_coeff(3)+bb1_M(frame_num))),'FontSize', 7);
    plot(fitted2(:,1),fitted2(:,2),'-','linewidth',0.5);
    text (position_bb(2,1)-30,position_bb(2,2)+25,strcat('y =',num2str(-bb2_coeff(1)),' *x^2 + ', num2str(bb2_coeff(2)),' *x + ', num2str(bb2_coeff(3)+bb2_M(frame_num))),'FontSize', 7);
    plot(fitted3(:,1),fitted3(:,2),'-','linewidth',0.5);
    text (position_bb(3,1)-30,position_bb(3,2)+25,strcat('y =',num2str(-bb3_coeff(1)),' *x^2 + ', num2str(bb3_coeff(2)),' *x + ', num2str(bb3_coeff(3)+bb3_M(frame_num))),'FontSize', 7);
end
%export_fig(save_path);
end

% % calculate coe of curves
% rb2_coeff = polyfit(rb2_x_coordination_havess, rb2_y_coordination_havess, 2);
% rb1_coeff = polyfit(rb1_x_coordination_havess, rb1_y_coordination_havess, 2);
% yb_coeff = polyfit(yb_x_coordination_havess, yb_y_coordination_havess, 2);
% black_coeff = polyfit(black_x_coordination_havess, black_y_coordination_havess, 2);
% wb1_coeff = polyfit(wb1_x_coordination_havess, wb1_y_coordination_havess, 2);
% wb2_coeff = polyfit(wb2_x_coordination_havess, wb2_y_coordination_havess, 2);
% bb_coeff = polyfit(bb_x_coordination_havess, bb_y_coordination_havess, 2);
% bb1_coeff = polyfit(bb_x_coordination_threeone, bb_y_coordination_threeone, 2);
% bb2_coeff = polyfit(bb_x_coordination_threetwo, bb_y_coordination_threetwo, 2);
% bb3_coeff = polyfit(bb_x_coordination_threethree, bb_y_coordination_threethree, 2);
% 










