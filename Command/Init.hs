{- git-annex command
 -
 - Copyright 2010 Joey Hess <joey@kitenet.net>
 -
 - Licensed under the GNU GPL version 3 or higher.
 -}

module Command.Init where

import Common.Annex
import Command
import Annex.UUID
import Logs.UUID
import Init
	
def :: [Command]
def = [dontCheck repoExists $
	command "init" paramDesc seek "initialize git-annex"]

seek :: [CommandSeek]
seek = [withWords start]

start :: [String] -> CommandStart
start ws = do
	showStart "init" description
	next $ perform description
	where
		description = unwords ws

perform :: String -> CommandPerform
perform description = do
	initialize
	getUUID >>= describeUUID description
	next $ return True
