function varargout = FamoceGUI(varargin)
% FAMOCEGUI MATLAB code for FamoceGUI.fig
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FamoceGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @FamoceGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before FamoceGUI is made visible.
function FamoceGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FamoceGUI (see VARARGIN)

% Choose default command line output for FamoceGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FamoceGUI wait for user response (see UIRESUME)
% uiwait(handles.figure_pjimage);
setappdata(handles.figure_pjimage,'img_src',0);
setappdata(handles.figure_pjimage,'src_fpath',0);
set(handles.txt_display,'String','Click File then open to load your face!');
axes(handles.axes_background);
imshow(imread('/initialBGD.png'));
% --- Outputs from this function are returned to the command line.
function varargout = FamoceGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function m_file_Callback(hObject, eventdata, handles)
% hObject    handle to m_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function m_file_open_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes_background);
imshow(imread('/mainBGD.jpg'));
[filename,pathname]=uigetfile({'*.bmp;*.jpg;*.png;*.jpeg,*.PNG','ImageFiles(*.bmp,*.jpg,*.png,*.jpeg)';'*.*','AllFiles(*.*)'},'Pickanimage');
if isequal(filename,0)||isequal(pathname,0)
    return;
end
axes(handles.axes_src);
src_fpath=[pathname filename];
img_src = imread(src_fpath);
imshow(img_src);
setappdata(handles.figure_pjimage,'img_src',img_src);
setappdata(handles.figure_pjimage,'src_fpath',src_fpath);
set(handles.txt_display,'String','Press FindLiu button!');
% --------------------------------------------------------------------
function m_file_save_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uiputfile({'*.PNG','PNG files';'*.bmp','BMP files';'*.jpg;','JPG files'},'PickanImage');
if isequal(filename,0)||isequal(pathname,0)
    return; %IF CANCEL
else
    fpath=fullfile(pathname,filename);
end
img_src = getappdata(handles.figure_pjimage,'img_src');
imwrite(img_src,fpath);
% --------------------------------------------------------------------
function m_file_exit_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.figure_pjimage);


% --- Executes on button press in confirm.
function confirm_Callback(hObject, eventdata, handles)
% hObject    handle to confirm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
src_fpath = getappdata(handles.figure_pjimage,'src_fpath');
if src_fpath == 0
    set(handles.txt_display,'ForegroundColor','r');
end
[line1_x, line2_x, line3_x, line4_x,line1_y,line2_y,line3_y,line4_y, img_dst] = main(src_fpath);
axes(handles.axes_dst);
imshow(img_dst);
hold on;
plot(line1_x,line1_y,'r','linewidth',2);
hold on;
plot(line2_x,line2_y,'r','linewidth',2);
hold on;
plot(line3_x,line3_y,'r','linewidth',2);
hold on;
plot(line4_x,line4_y,'r','linewidth',2);

set(handles.txt_display,'String','Liu Bolin is shown in red rectangle!!!');
setappdata(handles.figure_pjimage,'img_dst',imread(img_dst));
