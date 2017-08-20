function result = ContoursUnleaveSpikes(session,sesinfo)
%ContoursUnleaveSpikes	Rearrange spikes into salience values
%	RESULT = ContoursUnleaveSpikes(SESSION,SESINFO) takes the SESSION 
%	structure generated by GenerateSessionSpikeTrains and unleaves
%	the trials using SESINFO generated by ContoursGetSessionInfo. The
%	resulting structure RESULT has the following fields:
%		RESULT.duration
%		RESULT.contour(i).repetition(j).cluster(k).spikecount
%		RESULT.contour(i).repetition(j).cluster(k).spikes()
%		RESULT.control(i).repetition(j).cluster(k).spikecount
%		RESULT.control(i).repetition(j).cluster(k).spikes()
%		RESULT.catchcontour.repetition(j).cluster(k).spikecount
%		RESULT.catchcontour.repetition(j).cluster(k).spikes
%		RESULT.catchcontrol.repetition(j).cluster(k).spikecount
%		RESULT.catchcontrol.repetition(j).cluster(k).spikes()

index = 1;

result.duration = session.duration;

for i=1:sesinfo.stim_steps
	for j=1:sesinfo.stimsets
		result.contour(i).repetition(j) = session.trial(sesinfo.sequence(index));
		index = index + 1;
	end
end

for i=1:sesinfo.stim_steps
	for j=1:sesinfo.stimsets
		result.control(i).repetition(j) = session.trial(sesinfo.sequence(index));
		index = index + 1;
	end
end

if sesinfo.catchtrials==1
	catchsets = sesinfo.stimsets/2;
	for j=1:catchsets
		result.catchcontour.repetition(j) = session.trial(sesinfo.sequence(index));
		index = index + 1;
	end
	
	for j=1:catchsets
		result.catchcontrol.repetition(j) = session.trial(sesinfo.sequence(index));
		index = index + 1;
	end
end
