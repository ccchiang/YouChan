function varargout = TestKeySeqSpotting(varargin)
% TESTKEYSEQSPOTTING M-file for TestKeySeqSpotting.fig
%      TESTKEYSEQSPOTTING, by itself, creates a new TESTKEYSEQSPOTTING or raises the existing
%      singleton*.
%
%      H = TESTKEYSEQSPOTTING returns the handle to a new TESTKEYSEQSPOTTING or the handle to
%      the existing singleton*.
%
%      TESTKEYSEQSPOTTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTKEYSEQSPOTTING.M with the given input arguments.
%
%      TESTKEYSEQSPOTTING('Property','Value',...) creates a new TESTKEYSEQSPOTTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TestKeySeqSpotting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TestKeySeqSpotting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TestKeySeqSpotting

% Last Modified by GUIDE v2.5 04-Jul-2013 20:48:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TestKeySeqSpotting_OpeningFcn, ...
                   'gui_OutputFcn',  @TestKeySeqSpotting_OutputFcn, ...
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

% --- Executes just before TestKeySeqSpotting is made visible.
function TestKeySeqSpotting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TestKeySeqSpotting (see VARARGIN)

% Choose default command line output for TestKeySeqSpotting
handles.output = hObject;
% Update handles structure
fd = fopen('qdata_seq.txt', 'r');
stop = 0;
fnamelist = {};
short_fnamelist = {};
while (stop~=1) 
    d = fscanf(fd, '%d', 1);
    fname = fscanf(fd, '%s', 1);
    if (isempty(d))
        stop = 1;
    else
        short_fnamelist = [short_fnamelist;fname];
        fnamelist = [fnamelist;num2str(d,'%3d-') fname];
    end
end
fclose(fd);
handles.qfnamelst = short_fnamelist;
set(handles.listbox1, 'String', fnamelist);

fd = fopen('tdata_seq.txt', 'r');
stop = 0;
fnamelist = {};
short_fnamelist = {};
while (stop~=1) 
    d = fscanf(fd, '%d', 1);
    fname = fscanf(fd, '%s', 1);
    if (isempty(d))
        stop = 1;
    else
        short_fnamelist = [short_fnamelist;fname];
        fnamelist = [fnamelist;num2str(d,'%3d-') fname];
    end
end
fclose(fd);
set(handles.listbox2, 'String', fnamelist);
handles.tfnamelst = short_fnamelist;

guidata(hObject, handles);

% UIWAIT makes TestKeySeqSpotting wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TestKeySeqSpotting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
index_selected = get(hObject,'Value');
start = handles.nqframes(index_selected)+1;
stop = handles.nqframes(index_selected+1);
handles.qseq = handles.qdata(start:stop,:);
set(handles.text7, 'String', num2str(size(handles.qseq, 1)));

dur = [1 size(handles.qseq,1)];
filename_idx = get(handles.listbox1, 'Value');
filepath = ['G:\YouChanData\colorImg\' cell2mat(handles.qfnamelst(filename_idx))];
filepath = filepath(1:length(filepath)-4);
for i=dur(1):dur(2)
    filename = [filepath '\' num2str(i) '.png'];
    QM(i-dur(1)+1) = im2frame(imread(filename));
end
handles.QM = QM;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2
index_selected = get(hObject,'Value');
start = handles.ntframes(index_selected)+1;
stop = handles.ntframes(index_selected+1);
handles.tseq = handles.tdata(start:stop,:);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3
selected_index = get(hObject, 'Value');
dur = handles.cand(selected_index,:);
filename_idx = get(handles.listbox2, 'Value');
filepath = ['G:\YouChanData\colorImg\' cell2mat(handles.tfnamelst(filename_idx))];
filepath = filepath(1:length(filepath)-4);
for i=dur(1):dur(2)
    filename = [filepath '\' num2str(i) '.png'];
    TM(i-dur(1)+1) = im2frame(imread(filename));
end
handles.TM = TM;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox4.
function listbox4_Callback(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox4


% --- Executes during object creation, after setting all properties.
function listbox4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
LD = simmx(handles.qseq', handles.tseq'); % Compute the local distance matrix 
[p q D] = dp(LD); % Perform the DTW matching. p and q gives the path and D gives the computed DTW distance
[end_list d1] = FindEnd(D(end,:)); % Find all possible end points. Candidate points are in end_list and d1 are the corresponding distances
[start_list d2] = FindStart(handles.qseq, handles.tseq, end_list); % Reverse the sequences and find the end point for each candidate (found points are in start_list, d2 are the distances)
start_list = end_list - start_list + 1; % find the located start points in the non-reversed sequence
cand_list = [start_list' end_list'  min(d1',d2') d1' d2'] % Compose all candidates for spotted subsequences
best1 = cand_list(find(cand_list(:,4)==min(cand_list(:,4))),:) % Find the best one according to d1 distances
best2 = cand_list(find(cand_list(:,5)==min(cand_list(:,5))),:) % Find the best one according to d2 distances
best = cand_list(find(cand_list(:,3)==min(cand_list(:,3))),:) % Find the best one according to min(d1,d2)
scalefactor1 = 2.5;
scalefactor2 = 0.5;
len = size(handles.qseq, 1);
[handles.cand handles.scores] = RemoveRedundant(len, scalefactor1, scalefactor2, cand_list(:,1:2), cand_list(:,3));
durs = {}
for i=1:length(handles.scores)
    durs = [durs, [num2str(handles.cand(i,1),'%03d') '-' num2str(handles.cand(i,2),'%03d')]];
end
set(handles.listbox3, 'Value', 1);
set(handles.listbox3, 'String', durs);
set(handles.listbox4, 'String', handles.scores);
guidata(hObject, handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text5, 'String', 'Loading data ...');
nqframes = load('no_qdata.txt');
for i=1:length(nqframes)
    handles.nqframes(i) = sum(nqframes(1:i));
end
handles.nqframes = [0 handles.nqframes];
ntframes = load('no_tdata.txt');
for i=1:length(ntframes)
    handles.ntframes(i) = sum(ntframes(1:i));
end
handles.ntframes = [0 handles.ntframes];
handles.qdata = load('qdata_a.txt');
handles.tdata = load('tdata_a.txt');
set(handles.text5, 'String', 'Loading completed.');
guidata(hObject, handles);


% --- Executes on key press with focus on listbox3 and none of its controls.
function listbox3_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h1 = figure(1);
axis image;
movie(h1, handles.QM);

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

h2 = figure(2);
axis image;
movie(h2, handles.TM);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h2 = figure(2);
axis image;
movie(h2, handles.SM);

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dur1 = str2num(get(handles.edit1, 'String'));
dur2 = str2num(get(handles.edit2, 'String'));
filename_idx = get(handles.listbox2, 'Value');
filepath = ['G:\YouChanData\colorImg\' cell2mat(handles.tfnamelst(filename_idx))];
filepath = filepath(1:length(filepath)-4);
for i=dur1:dur2
    filename = [filepath '\' num2str(i) '.png'];
    SM(i-dur1+1) = im2frame(imread(filename));
end
handles.SM = SM;
guidata(hObject, handles);