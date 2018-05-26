classdef LCDAddon < arduinoio.LibraryBase 
    properties(Access = private, Constant = true)
        LCD_CREATE     = hex2dec('00')
        LCD_INITIALIZE = hex2dec('01')
        LCD_CLEAR      = hex2dec('02')
        LCD_PRINT      = hex2dec('03')
        LCD_DELETE     = hex2dec('04')
    end
    properties(Access = protected, Constant = true)
        LibraryName = 'ExampleLCD/LCDAddon'
        DependentLibraries = {}
        ArduinoLibraryHeaderFiles = 'LiquidCrystal/LiquidCrystal.h'
        CppHeaderFile = fullfile(arduinoio.FilePath(mfilename('fullpath')), 'src', 'LCD.h')
        CppClassName = 'LCD'
    end    

    properties(Access = private)
        ResourceOwner = 'ExampleLCD/LCDAddon';
        Rows
        Columns
    end
    methods(Hidden, Access = public)
        function obj = LCD(parentObj,inputPins)
            obj.Parent = parentObj;
            obj.Pins = inputPins;
            count = getResourceCount(obj.Parent,obj.ResourceOwner);
            % Since this example allows implementation of only 1 LCD
            % shield, error out if resource count is more than 0
            if count > 0
                error('You can only have 1 LCD shield');
            end 
            incrementResourceCount(obj.Parent,obj.ResourceOwner);    
            createLCD(obj,inputPins);
        end
        function createLCD(obj,inputPins)
            try
                cmdID = obj.LCD_CREATE;
                
                for iLoop = inputPins
                    configurePinResource(obj.Parent,iLoop{:},obj.ResourceOwner,'Reserved');
                end
                
                terminals = getTerminalsFromPins(obj.Parent,inputPins);
                sendCommand(obj, obj.LibraryName, cmdID, terminals);
            catch e
                throwAsCaller(e);
            end
        end
    end
    methods(Access = protected)
        function delete(obj)
            try
                parentObj = obj.Parent;
                
                for iLoop = obj.Pins
                    configurePinResource(parentObj,iLoop{:},obj.ResourceOwner,'Unset');
                end
                
                decrementResourceCount(parentObj, obj.ResourceOwner);
                cmdID = obj.LCD_DELETE;
                inputs = [];
                sendCommand(obj, obj.LibraryName, cmdID, inputs);
            catch
                
            end
        end  
    end
    methods(Access = public)
        function initializeLCD(obj,varargin)                                    
            p = inputParser;
            p.PartialMatching = true;
            
            addParameter(p, 'Rows', 2);
            addParameter(p, 'Columns', 16);
            parse(p, varargin{:});
            output = p.Results;
            
            obj.Rows = output.Rows;
            obj.Columns = output.Columns;
            inputs = [output.Columns output.Rows];
            
            cmdID = obj.LCD_INITIALIZE;  
            sendCommand(obj, obj.LibraryName, cmdID, inputs);
        end
        function clearLCD(obj)
            cmdID = obj.LCD_CLEAR;
            inputs = [];
            sendCommand(obj, obj.LibraryName, cmdID, inputs);
        end
        function printLCD(obj,message)
            cmdID = obj.LCD_PRINT;
            
            if numel(message) > 16
                error('Cannot print more than 16 characters')
            end
            
            inputs = [double(message) obj.Columns obj.Rows];
            sendCommand(obj, obj.LibraryName, cmdID, inputs); 
        end       
    end
end