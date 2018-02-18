
-- A small and simple Translation manager for your love2d games!
-- you can find it on github: https://github.com/RafaelC1/LoveLanguages
-- @author: RafaelC1
-- @licence: MIT

LoveLanguages = {}

function LoveLanguages.new(args)
    local defaultLanguages =
    {
        "pt",
        "eng",
        "span"
    }
    local self =
    {
        translationsPath = "",
        currentLanguage = "pt",
        availableLanguages = {},
        keyValuesTable = {}
    }
    self.translationsPath = args.path or "translations"
    self.availableLanguages = args.languages or defaultLanguages

    --call this method and pass a tring on format "pt" to add a new language, the file need to exist
    function self.add_language(newLanguage)
        if self.language_exist(newLanguage) then return end
        self.language[#self.language + 1] = newLanguage
        self.add_keys_on_key_table()
    end
    --call this method and pass the current language of program
    function self.set_language(language)
        if not self.language_exist(language) then return end
        self.currentLanguage = language
    end
    --call this method and pass some key to get the valye if it exist
    function self.translation_of(key)
        local value = self.keyValuesTable[self.currentLanguage][key]
        if value == nil then value = "missing key" end
        return value
    end
    --get current language
    function self.current_language_stats()
        return self.currentLanguage
    end
    --check if some language already exist
    function self.language_exist(language)
        local language_exist = false
        for i, lang in ipairs(self.availableLanguages) do
            if(lang == language) then language_exist = true end
        end
        return language_exist
    end
    --after add a new translation, add a table for it be loaded from some external .txt file
    function self.add_file_keys_to_table()
        for i = 1, #self.availableLanguages do
            if self.keyValuesTable[self.availableLanguages[i]] == nil then
                self.keyValuesTable[self.availableLanguages[i]] = {}
            end
        end
    end
    --read file and put key and value on the correct table
    function self.add_keys_and_values_to_table()
        local paths = {}
        for i, lang in ipairs(self.availableLanguages) do
            paths[#paths + 1] = self.translationsPath .. "all_" .. lang .. ".txt"
        end
        for i, path in ipairs(paths) do
            self.keyValuesTable[self.availableLanguages[i]] = keys_and_values_from_file(path)
        end
    end
    
    --go one translation foward
    function self.next_translation()
        for i, lang in ipairs(self.availableLanguages) do
            if lang == self.currentLanguage then
                local newLang = "pt"
                if #self.availableLanguages > i then
                    newLang = self.availableLanguages[i + 1]
                else
                    newLang = self.availableLanguages[1]
                end
                self.currentLanguage = newLang
                update_all_translations_of_objects()
                return
            end
        end
    end
    --chekc if path is acording with rules
    function check_path()
        if string.find(self.translationsPath , "/") == string.sub(self.translationsPath , #self.translationsPath , #self.translationsPath) then
            return
        else
            self.translationsPath  = self.translationsPath  .. "/"
        end
    end

    check_path()
    self.add_file_keys_to_table()
    self.add_keys_and_values_to_table()

    return self
end

--files helpers
--check if file exist on passed path
function file_exist(filePath)
    local exist = love.filesystem.exists(filePath)
    return exist
end
--read file and give key values back format if file has it
function keys_and_values_from_file(filePath)
    local table = {}
    if file_exist(filePath) then
        for line in love.filesystem.lines(filePath) do
            local key = string.sub(line, 1, string.find(line, ":")-1)
            local value = string.sub(line, string.find(line, ":")+1, #line)
            table[key] = value
        end
    end
    return table
end