% Audio System Script
% This script allows you to choose between Mono (Left/Right), Stereo, Mono (Single Channel), or Dolby audio processing

clear all;
clc;
close all;

% Load an audio file
[file, path] = uigetfile({'*.mp3;*.wav', 'Audio Files (*.mp3, *.wav)'}, 'Select an Audio File', 'C:\Users\YourUsername\Desktop\');
if isequal(file, 0)
    disp('No file selected. Exiting...');
    return;
end

% Read the selected audio file
[audio, fs] = audioread(fullfile(path, file));

while true
    % Display options
    disp('Select Audio Mode:');
    disp('1. Mono (Left)');
    disp('2. Mono (Right)');
    disp('3. Stereo');
    disp('4. Mono (Single Channel)');
    disp('5. Dolby');
    disp('6. Exit');

    choice = input('Enter your choice (1/2/3/4/5/6): ');

    switch choice
        case 1 % Mono (Left)
            % Use the left channel
            if size(audio, 2) == 2
                audioMono = audio(:, 1);
            else
                audioMono = audio; % Already mono
            end
            % Create a stereo signal with mono audio on the left channel
            audioMonoLeft = [audioMono, zeros(size(audioMono))];
            disp('Mono (Left) processing applied.');
            % Plot Mono (Left) audio waveform
            figure;
            plot((1:length(audioMono))/fs, audioMono);
            title('Mono (Left) Audio');
            xlabel('Time (s)');
            ylabel('Amplitude');
            % Play Mono (Left) audio
            sound(audioMonoLeft, fs);
            % Display selection
            disp('Playing Mono (Left) audio.');
            
        case 2 % Mono (Right)
            % Use the right channel
            if size(audio, 2) == 2
                audioMono = audio(:, 2);
            else
                audioMono = audio; % Already mono
            end
            % Create a stereo signal with mono audio on the right channel
            audioMonoRight = [zeros(size(audioMono)), audioMono];
            disp('Mono (Right) processing applied.');
            % Plot Mono (Right) audio waveform
            figure;
            plot((1:length(audioMono))/fs, audioMono);
            title('Mono (Right) Audio');
            xlabel('Time (s)');
            ylabel('Amplitude');
            % Play Mono (Right) audio
            sound(audioMonoRight, fs);
            % Display selection
            disp('Playing Mono (Right) audio.');
            
        case 3 % Stereo
            % Ensure the audio is stereo
            if size(audio, 2) == 1
                audioStereo = [audio, audio]; % Duplicate mono channel
            else
                audioStereo = audio; % Already stereo
                % Ensure both channels have non-zero data
                if all(audioStereo(:, 1) == 0)
                    audioStereo(:, 1) = audioStereo(:, 2);
                elseif all(audioStereo(:, 2) == 0)
                    audioStereo(:, 2) = audioStereo(:, 1);
                end
            end
            disp('Stereo processing applied.');
            % Plot Stereo audio waveform
            figure;
            if size(audioStereo, 2) == 2
                plot((1:length(audioStereo))/fs, audioStereo(:, 1), 'b', (1:length(audioStereo))/fs, audioStereo(:, 2), 'r');
            else
                plot((1:length(audioStereo))/fs, audioStereo);
            end
            title('Stereo Audio');
            xlabel('Time (s)');
            ylabel('Amplitude');
            % Play Stereo audio
            sound(audioStereo, fs);
            % Display selection
            disp('Playing Stereo audio.');
            
        case 4 % Mono (Single Channel)
            % Convert to Mono by averaging the channels if necessary
            if size(audio, 2) == 2
                audioMono = mean(audio, 2);
            else
                audioMono = audio; % Already mono
            end
            disp('Mono (Single Channel) processing applied.');
            % Plot Mono audio waveform
            figure;
            plot((1:length(audioMono))/fs, audioMono);
            title('Mono (Single Channel) Audio');
            xlabel('Time (s)');
            ylabel('Amplitude');
            % Play Mono audio
            sound(audioMono, fs);
            % Display selection
            disp('Playing Mono (Single Channel) audio.');
            
        case 5 % Dolby
            % Convert to Dolby by duplicating the mono channel or using existing channels
            if size(audio, 2) == 1
                audioDolby = repmat(audio, 1, 5); % Duplicate mono channel for all five channels
            else
                audioDolby = audio; % Start with existing channels
                % Add additional channels if less than 5
                if size(audioDolby, 2) < 5
                    for i = size(audioDolby, 2)+1:5
                        audioDolby(:, i) = audioDolby(:, 1); % Duplicate first channel to fill
                    end
                end
                % Ensure channels 2-5 are non-zero
                for i = 2:5
                    if all(audioDolby(:, i) == 0)
                        audioDolby(:, i) = audioDolby(:, 1);
                    end
                end
            end
            disp('Dolby processing applied.');
            % Plot Dolby audio waveform
            figure;
            for i = 1:5
                subplot(5, 1, i);
                plot((1:length(audioDolby))/fs, audioDolby(:, i));
                title(['Channel ' num2str(i)]);
                xlabel('Time (s)');
                ylabel('Amplitude');
            end
            % Display selection
            disp('Dolby audio array created.');
            
        case 6 % Exit
            disp('Exiting...');
            break;
            
        otherwise
            disp('Invalid choice. Please try again.');
    end

    % Display the processed audio array
    disp('Processed audio array:');
    if choice == 1
        disp(audioMonoLeft);
    elseif choice == 2
        disp(audioMonoRight);
    elseif choice == 3
        disp(audioStereo);
    elseif choice == 4
        disp(audioMono);
    elseif choice == 5
        disp(audioDolby);
    end
end

disp('Processing complete.');
